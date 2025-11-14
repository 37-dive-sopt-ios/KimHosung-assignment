//
//  BaeminBadgeCollectionViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import SnapKit

import UIKit

final class BaeminBadgeCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Component
    let badgeView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminMint50010
        view.layer.cornerRadius = 4
        view.layer.borderColor = UIColor.baeminMint500.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let baeminClubImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .baeminClub)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "배민클럽"
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
        badgeView.addSubviews(
            baeminClubImageView,
            titleLabel,
        )
    }
    
    private func setupLayout() {
        badgeView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        baeminClubImageView.snp.makeConstraints({
            $0.size.equalTo(10)
            $0.verticalEdges.equalToSuperview().inset(3)
            $0.leading.equalToSuperview().inset(5)
        })
        titleLabel.snp.makeConstraints({
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(baeminClubImageView.snp.trailing).offset(2)
            $0.trailing.equalToSuperview().inset(5)
        })
    }
}
