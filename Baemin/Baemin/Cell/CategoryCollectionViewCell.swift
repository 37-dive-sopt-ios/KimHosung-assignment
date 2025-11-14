//
//  CategoryCollectionViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.11.
//

import SnapKit

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Component
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .baeminBackgroundWhite
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.body_r_14)
        label.textColor = .baeminBlack
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
            mainImageView,
            titleLabel,
        )
    }
    
    private func setupLayout() {
        mainImageView.snp.makeConstraints({
            $0.top.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(2)
            $0.size.equalTo(58)
        })
        titleLabel.snp.makeConstraints({
            $0.top.equalTo(mainImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        })
    }
}
