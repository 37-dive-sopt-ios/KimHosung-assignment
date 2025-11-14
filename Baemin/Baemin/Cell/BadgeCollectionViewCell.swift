//
//  BadgeCollectionViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import SnapKit

import UIKit

final class BadgeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Component
    let badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBackgroundWhite
        view.layer.cornerRadius = 4
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .baeminGray800
        label.font = .pretendard(.title_sb_10)
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
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .baeminWhite
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(
            badgeView,
        )
        badgeView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        badgeView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        titleLabel.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(5)
            $0.verticalEdges.equalToSuperview().inset(3)
        })
    }
}
