//
//  RankingTableViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.12.
//

import SnapKit

import UIKit

final class RankingTableViewCell: UITableViewCell {
    
    // MARK: - Property
    private let oneBowlModels: [OneBowlModel] = [
        OneBowlModel(image: UIImage(resource: .bunsik), marketName: "백억보쌈제육", rating: 5.0, ratingCount: 1973, title: "[든든한 한끼] 보쌈 막국수", discountRate: 25, price: 12000, originPrice: 16000, minimumOrder: nil),
        OneBowlModel(image: UIImage(resource: .pizza), marketName: "백억보쌈제육", rating: 5.0, ratingCount: 1973, title: "(1인) 피자 + 사이드 Set", discountRate: 20, price: 12000, originPrice: 16000, minimumOrder: nil),
        OneBowlModel(image: UIImage(resource: .oneBowl), marketName: "백억보쌈제육", rating: 5.0, ratingCount: 1973, title: "(1인) 피자 Set", discountRate: 10, price: 10000, originPrice: 11000, minimumOrder: 10000),
    ]
    
    // MARK: - Component
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(rgb: 0x7276FF)
        return view
    }()
    
    let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.colors = [UIColor(rgb: 0x7276FF), .baeminWhite]
        gradientView.locations = [0, 1]
        gradientView.startPoint = .init(x: 0.5, y: 0)
        gradientView.endPoint = .init(x: 0.5, y: 1)
        return gradientView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 동네 한그릇 인기 랭킹"
        label.font = .pretendard(.title_sb_18)
        label.textColor = .baeminWhite
        return label
    }()
    
    let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .info), for: .normal)
        return button
    }()
    
    let allButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.title = "전체보기"
        configuration.image = UIImage(resource: .chevronRight).withTintColor(.baeminWhite)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        configuration.titleAlignment = .leading
        configuration.contentInsets = .zero
        
        button.configuration = configuration
        button.tintColor = .baeminWhite
        return button
    }()
    
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OneBowlCollectionViewCell.self)
        collectionView.backgroundColor = .clear
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
            backgroundGradientView,
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
        backgroundGradientView.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(64)
            $0.top.equalTo(headerView.snp.bottom)
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(24)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(8)
        })
        infoButton.snp.makeConstraints({
            $0.size.equalTo(16)
            $0.leading.equalTo(titleLabel.snp.trailing).offset(2)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        })
        allButton.snp.makeConstraints({
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(titleLabel.snp.centerY)
        })
        mainCollectionView.snp.makeConstraints({
            $0.top.equalTo(headerView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(283)
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
extension RankingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return oneBowlModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OneBowlCollectionViewCell.identifier, for: indexPath) as? OneBowlCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(oneBowlModel: oneBowlModels[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.d(indexPath.item)
    }
}
