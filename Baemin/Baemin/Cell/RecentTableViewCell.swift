//
//  RecentTableViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import SnapKit

import UIKit

final class RecentTableViewCell: UITableViewCell {
    
    // MARK: - Property
    private let recentMarketModels: [RecentMarketModel] = [
        RecentMarketModel(image: UIImage(resource: .pizza), recentOrderCount: 1, marketName: "ASAP PIZZA 구로디지털단지", rating: 5.0, ratingCount: 504, deliveryTime: 31...46, isDeliveryFree: true, badges: [.baeminClub, .custom("픽업가능")]),
        RecentMarketModel(image: UIImage(resource: .soup), recentOrderCount: 3, marketName: "레전드 고기한상", rating: 4.9, ratingCount: 1504, deliveryTime: 31...46, isDeliveryFree: true, badges: [.baeminClub, .custom("픽업가능"), .custom("예약가능")]),
    ]
    
    // MARK: - Component
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminWhite
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "최근에 주문했어요"
        label.font = .pretendard(.title_sb_18)
        label.textColor = .baeminBlack
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .info).withTintColor(.baeminBlack), for: .normal)
        return button
    }()
    
    let allButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.title = "전체보기"
        configuration.image = UIImage(resource: .chevronRight)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        configuration.titleAlignment = .leading
        configuration.contentInsets = .zero
        
        button.configuration = configuration
        button.tintColor = .baeminBlack
        return button
    }()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecentMarketCollectionViewCell.self)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 10, left: 16, bottom: 20, right: 16)
        return collectionView
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
        )
        headerView.addSubviews(
            titleLabel,
            infoButton,
            allButton,
        )
    }
    
    private func setupLayout() {
        headerView.snp.makeConstraints({
            $0.top.horizontalEdges.equalToSuperview()
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        })
        infoButton.snp.makeConstraints({
            $0.size.equalTo(16)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(3)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        })
        allButton.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        })
        mainCollectionView.snp.makeConstraints({
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(246)
        })
    }
    
    private func setupComponentAction() {
        infoButton.addTarget(self, action: #selector(onClickInfoButton), for: .touchUpInside)
        allButton.addTarget(self, action: #selector(onClickAllButton), for: .touchUpInside)
    }
    
    // MARK: - Component Action
    @objc private func onClickInfoButton() {
        Log.d("onClickInfoButton")
    }
    
    @objc private func onClickAllButton() {
        Log.d("onClickAllButton")
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension RecentTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentMarketModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecentMarketCollectionViewCell.identifier, for: indexPath) as? RecentMarketCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(recentMarketModel: recentMarketModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.d(indexPath.item)
    }
}
