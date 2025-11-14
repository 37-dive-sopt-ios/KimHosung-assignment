//
//  OneBowlCollectionViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import SnapKit

import UIKit

final class OneBowlCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Component
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .baeminGray200
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let topSubInfoView: UIView = {
        let view = UIView()
        return view
    }()
    
    let marketLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminGray600
        label.font = .pretendard(.body_r_12)
        return label
    }()
    
    let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .star)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminGray600
        label.font = .pretendard(.body_r_12)
        return label
    }()
    
    let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminGray600
        label.font = .pretendard(.body_r_12)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminBlack
        label.font = .pretendard(.body_r_14)
        return label
    }()
    
    let priceView: UIView = {
        let view = UIView()
        return view
    }()
    
    let discountRateLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0xFF1C30)
        label.font = .pretendard(.head_b_14)
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminBlack
        label.font = .pretendard(.head_b_14)
        return label
    }()
    
    let originPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminGray600
        label.font = .pretendard(.body_r_12)
        return label
    }()
    
    let minimumOrderLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x5415FF)
        label.font = .pretendard(.head_b_13)
        return label
    }()
    
    // MARK: - Basic
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(oneBowlModel: OneBowlModel) {
        mainImageView.image = oneBowlModel.image
        marketLabel.text = oneBowlModel.marketName
        ratingLabel.text = oneBowlModel.rating.toString(decimalPlace: 1)
        ratingCountLabel.text = "(\(oneBowlModel.ratingCount.toFormattedString()))"
        titleLabel.text = oneBowlModel.title
        discountRateLabel.text = "\(oneBowlModel.discountRate)%"
        priceLabel.text = "\(oneBowlModel.price.toFormattedString())원"
        originPriceLabel.attributedText = "\(oneBowlModel.originPrice.toFormattedString())원".strikeThrough()
        if let minimumOrder = oneBowlModel.minimumOrder {
            minimumOrderLabel.text = "최소주문금액 \(minimumOrder.toFormattedString())원"
        } else {
            minimumOrderLabel.text = "최소주문금액 없음"
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .clear
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(
            mainImageView,
            infoStackView,
        )
        infoStackView.addArrangedSubviews(
            topSubInfoView,
            titleLabel,
            priceView,
            originPriceLabel,
            minimumOrderLabel,
        )
        topSubInfoView.addSubviews(
            marketLabel,
            starImageView,
            ratingLabel,
            ratingCountLabel,
        )
        priceView.addSubviews(
            discountRateLabel,
            priceLabel,
        )
    }
    
    private func setupLayout() {
        mainImageView.snp.makeConstraints({
            $0.size.equalTo(145)
            $0.top.horizontalEdges.equalToSuperview()
        })
        infoStackView.snp.makeConstraints({
            $0.top.equalTo(mainImageView.snp.bottom).offset(9)
            $0.horizontalEdges.bottom.equalToSuperview()
        })
        marketLabel.snp.makeConstraints({
            $0.leading.verticalEdges.equalToSuperview()
            $0.trailing.equalTo(topSubInfoView.snp.centerX)
        })
        starImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(marketLabel.snp.trailing).offset(5)
            $0.width.equalTo(11)
            $0.height.equalTo(10)
        })
        ratingLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(starImageView.snp.trailing).offset(2)
        })
        ratingCountLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(4)
        })
        discountRateLabel.snp.makeConstraints({
            $0.leading.verticalEdges.equalToSuperview()
        })
        priceLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(discountRateLabel.snp.trailing).offset(6)
        })
    }
}
