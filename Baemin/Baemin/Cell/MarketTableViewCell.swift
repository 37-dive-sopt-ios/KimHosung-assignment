//
//  MarketTableViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.12.
//

import SnapKit

import UIKit

final class MarketTableViewCell: UITableViewCell {
    
    // MARK: - Enum
    enum Market: Int, CaseIterable {
        case bmart
        case cu
        case emartEveryday
        case homeplus
        case gs25
        case emart24
        
        var title: String {
            switch self {
            case .bmart: return "B마트"
            case .cu: return "CU"
            case .emartEveryday: return "이마트슈퍼"
            case .homeplus: return "홈플러스"
            case .gs25: return "GS25"
            case .emart24: return "이마트"
            }
        }
        
        var image: UIImage {
            switch self {
            case .bmart:
                return UIImage(resource: .bmart)
            case .cu:
                return UIImage(resource: .cu)
            case .emartEveryday:
                return UIImage(resource: .emartEveryday)
            case .homeplus:
                return UIImage(resource: .homeplus)
            case .gs25:
                return UIImage(resource: .gs25)
            case .emart24:
                return UIImage(resource: .emart24)
            }
        }
    }
    
    // MARK: - Component
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .baeminWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 11, left: 16, bottom: 11, right: 16)
        collectionView.register(CategoryCollectionViewCell.self)
        return collectionView
    }()
    
    // MARK: - Basic
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
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
        contentView.addSubview(mainCollectionView)
    }
    
    private func setupLayout() {
        mainCollectionView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.height.equalTo(96)
        })
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension MarketTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Market.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let market = Market(rawValue: indexPath.row) else {
            Log.e("IndexPath Row is out of range: \(indexPath)")
            return cell
        }
        cell.titleLabel.text = market.title
        cell.mainImageView.image = market.image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.d(indexPath.item)
    }
}
