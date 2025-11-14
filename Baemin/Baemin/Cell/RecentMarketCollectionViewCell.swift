//
//  RecentMarketCollectionViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import SnapKit

import UIKit

final class RecentMarketCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Property
    private var badges: [RecentMarketModel.Badge] = []
    
    // MARK: - Component
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .baeminGray200
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let recentOrderImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .time)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let recentOrderCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x007EFF)
        label.font = .pretendard(.body_r_12)
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let titleView: UIView = {
        let view = UIView()
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminBlack
        label.font = .pretendard(.head_b_14)
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
        label.textColor = .baeminBlack
        label.font = .pretendard(.head_b_14)
        return label
    }()
    
    let ratingCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminGray600
        label.font = .pretendard(.body_r_14)
        return label
    }()
    
    let deliveryView: UIView = {
        let view = UIView()
        return view
    }()
    
    let deliveryTimeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .money)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminBlack
        label.font = .pretendard(.body_r_13)
        return label
    }()
    
    let deliveryFreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .baeminClub)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let deliveryFreeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(rgb: 0x5415FF)
        label.font = .pretendard(.head_b_13)
        return label
    }()
    
    let badgeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 4
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(BaeminBadgeCollectionViewCell.self)
        collectionView.register(BadgeCollectionViewCell.self)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    // MARK: - Basic
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        badgeCollectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(recentMarketModel: RecentMarketModel) {
        mainImageView.image = recentMarketModel.image
        recentOrderCountLabel.text = "최근 \(recentMarketModel.recentOrderCount)번 주문한 가게"
        titleLabel.text = recentMarketModel.marketName
        ratingLabel.text = recentMarketModel.rating.toString(decimalPlace: 1)
        ratingCountLabel.text = "(\(recentMarketModel.ratingCount.toFormattedString()))"
        deliveryTimeLabel.text = "\(recentMarketModel.deliveryTime.lowerBound)~\(recentMarketModel.deliveryTime.upperBound)분"
        deliveryFreeLabel.text = recentMarketModel.isDeliveryFree ? "무료배송" : "유료배송"
        badges = recentMarketModel.badges
        badgeCollectionView.reloadData()
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .baeminWhite
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(
            mainImageView,
            recentOrderImageView,
            recentOrderCountLabel,
            infoStackView,
        )
        infoStackView.addArrangedSubviews(
            titleView,
            deliveryView,
            badgeCollectionView,
        )
        titleView.addSubviews(
            titleLabel,
            starImageView,
            ratingLabel,
            ratingCountLabel,
        )
        deliveryView.addSubviews(
            deliveryTimeImageView,
            deliveryTimeLabel,
            deliveryFreeImageView,
            deliveryFreeLabel,
        )
    }
    
    private func setupLayout() {
        mainImageView.snp.makeConstraints({
            $0.width.equalTo(188)
            $0.height.equalTo(126)
            $0.top.horizontalEdges.equalToSuperview()
        })
        recentOrderImageView.snp.makeConstraints({
            $0.size.equalTo(12)
            $0.top.equalTo(mainImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview()
        })
        recentOrderCountLabel.snp.makeConstraints({
            $0.centerY.equalTo(recentOrderImageView.snp.centerY)
            $0.leading.equalTo(recentOrderImageView.snp.trailing).offset(2)
        })
        infoStackView.snp.makeConstraints({
            $0.top.equalTo(recentOrderImageView.snp.bottom).offset(9)
            $0.horizontalEdges.bottom.equalToSuperview()
        })
        titleLabel.snp.makeConstraints({
            $0.leading.verticalEdges.equalToSuperview()
        })
        starImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(1)
            $0.width.equalTo(11)
            $0.height.equalTo(10)
        })
        ratingLabel.snp.makeConstraints({
            $0.width.greaterThanOrEqualTo(22)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(starImageView.snp.trailing).offset(2)
        })
        ratingCountLabel.snp.makeConstraints({
            $0.width.greaterThanOrEqualTo(22)
            $0.centerY.trailing.equalToSuperview()
            $0.leading.equalTo(ratingLabel.snp.trailing).offset(1)
        })
        deliveryTimeImageView.snp.makeConstraints({
            $0.size.equalTo(13)
            $0.leading.verticalEdges.equalToSuperview()
        })
        deliveryTimeLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(deliveryTimeImageView.snp.trailing).offset(2)
        })
        deliveryFreeImageView.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.size.equalTo(12)
            $0.leading.equalTo(deliveryTimeLabel.snp.trailing).offset(6)
        })
        deliveryFreeLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(deliveryFreeImageView.snp.trailing).offset(1)
        })
        badgeCollectionView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(16)
        })
    }
}

extension RecentMarketCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return badges.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch badges[indexPath.item] {
        case .baeminClub:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BaeminBadgeCollectionViewCell.identifier, for: indexPath) as? BaeminBadgeCollectionViewCell else {
                return UICollectionViewCell()
            }
            return cell
        case .custom(let title):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BadgeCollectionViewCell.identifier, for: indexPath) as? BadgeCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.titleLabel.text = title
            return cell
        }
    }
}
