//
//  TabBarIndexCollectionViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.10.
//

import SnapKit

import UIKit

final class TabBarIndexCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Component
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.head_b_18)
        label.textColor = .baeminGray300
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
    
    override var isSelected: Bool {
        didSet {
            titleLabel.textColor = isSelected ? .baeminBlack : .baeminGray300
        }
    }
    
    // MARK: - Setup
    private func setupUI() {
        backgroundColor = .baeminWhite
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints({
            $0.horizontalEdges.equalToSuperview().inset(2)
            $0.top.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(14)
        })
    }
}
