//
//  DiscountTableViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import SnapKit

import UIKit

final class DiscountTableViewCell: UITableViewCell {
    
    // MARK: - Property
    private let discountMarketModels: [DiscountMarketModel] = [
        DiscountMarketModel(image: UIImage(resource: .chicken), marketName: "제육고집 신림본점", rating: 5.0, ratingCount: 2504, deliveryTime: 31...46, isDeliveryFree: true, badges: [.baeminClub, .custom("소비쿠폰"), .custom("픽업가능"), .custom("위생인증")]),
        DiscountMarketModel(image: UIImage(resource: .bunsik), marketName: "파스타예요 영등포점", rating: 4.9, ratingCount: 1504, deliveryTime: 31...46, isDeliveryFree: true, badges: [.baeminClub, .custom("소비쿠폰"), .custom("픽업가능"), .custom("위생인증")]),
    ]
    
    // MARK: - Component
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminWhite
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "무조건 할인하는 가게"
        label.font = .pretendard(.title_sb_18)
        label.textColor = .baeminBlack
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .info).withTintColor(.baeminBlack), for: .normal)
        return button
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "2천원 이상 또는 15% 이상 할인중"
        label.font = .pretendard(.body_r_14)
        label.textColor = .baeminGray300
        return label
    }()
    
    let discountImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .discount)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DiscountMarketCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 11, left: 16, bottom: 10, right: 16)
        return collectionView
    }()
    
    let footerView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminWhite
        return view
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.contentInsets = .init(top: 10, leading: 12, bottom: 10, trailing: 12)
        configuration.image = UIImage(resource: .chevronRight)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 2
        configuration.titleAlignment = .center
        
        button.backgroundColor = .baeminWhite
        button.configuration = configuration
        button.tintColor = .baeminBlack
        button.layer.cornerRadius = 18
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.baeminGray200.cgColor
        
        let title = "할인하는 가게 더보기"
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [
            .font: UIFont.pretendard(.body_r_14)
        ])
        if let range = title.range(of: "할인하는 가게") {
            let nsRange = NSRange(range, in: title)
            attributedTitle.addAttributes([
                .font: UIFont.pretendard(.head_b_14)
            ], range: nsRange)
        }
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    // MARK: - Basic
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupComponentAction()
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .baeminWhite
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(
            headerView,
            mainCollectionView,
            footerView,
        )
        headerView.addSubviews(
            titleLabel,
            infoButton,
            subtitleLabel,
            discountImageView,
        )
        footerView.addSubview(moreButton)
    }
    
    private func setupLayout() {
        headerView.snp.makeConstraints({
            $0.top.horizontalEdges.equalToSuperview()
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(28)
            $0.leading.equalToSuperview().inset(16)
        })
        subtitleLabel.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        })
        infoButton.snp.makeConstraints({
            $0.size.equalTo(16)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(3)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        })
        discountImageView.snp.makeConstraints({
            $0.width.equalTo(66)
            $0.height.equalTo(59)
            $0.trailing.equalToSuperview().inset(23)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        })
        mainCollectionView.snp.makeConstraints({
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(240)
        })
        footerView.snp.makeConstraints({
            $0.top.equalTo(mainCollectionView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        })
        moreButton.snp.makeConstraints({
            $0.top.bottom.equalToSuperview().inset(10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(34)
        })
    }
    
    private func setupComponentAction() {
        infoButton.addTarget(self, action: #selector(onClickInfoButton), for: .touchUpInside)
        moreButton.addTarget(self, action: #selector(onClickMoreButton), for: .touchUpInside)
    }
    
    // MARK: - Component Action
    @objc private func onClickInfoButton() {
        Log.d("onClickInfoButton")
    }
    
    @objc private func onClickMoreButton() {
        Log.d("onClickMoreButton")
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension DiscountTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return discountMarketModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DiscountMarketCollectionViewCell.identifier, for: indexPath) as? DiscountMarketCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(discountMarketModel: discountMarketModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.d(indexPath.item)
    }
}
