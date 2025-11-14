//
//  AdvertisementTableViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.12.
//

import SnapKit

import UIKit

final class AdvertisementTableViewCell: UITableViewCell {
    
    // MARK: - Component
    let advertisementImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .ads)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Basic
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
        contentView.addSubview(advertisementImageView)
    }
    
    private func setupLayout() {
        advertisementImageView.snp.makeConstraints({
            $0.edges.equalToSuperview()
            $0.height.equalTo(200)
        })
    }
}
