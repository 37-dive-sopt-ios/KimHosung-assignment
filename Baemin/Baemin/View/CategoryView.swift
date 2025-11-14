//
//  CategoryView.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.11.
//

import SnapKit

import UIKit

final class CategoryView: UIView {
    
    // MARK: - Component
    let mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 12
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .baeminWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = .init(top: 12, left: 16, bottom: 21, right: 16)
        collectionView.isScrollEnabled = false
        return collectionView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBackgroundWhite
        return view
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.image = UIImage(resource: .chevronRight)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 2
        configuration.titleAlignment = .leading
        configuration.contentInsets = .zero
        
        button.backgroundColor = .baeminWhite
        button.configuration = configuration
        button.tintColor = .baeminBlack
        return button
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
        addSubviews(
            mainCollectionView,
            separatorView,
            moreButton,
        )
    }
    
    private func setupLayout() {
        mainCollectionView.snp.makeConstraints({
            $0.top.horizontalEdges.equalToSuperview()
            $0.height.equalTo(201)
        })
        separatorView.snp.makeConstraints({
            $0.top.equalTo(mainCollectionView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        })
        moreButton.snp.makeConstraints({
            $0.top.equalTo(separatorView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(34)
        })
    }
    
    // MARK: - Global Function
    func setmoreButtonTitle(_ category: String) {
        let title = "\(category)에서 더보기"
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [
            .font: UIFont.pretendard(.body_r_14)
        ])
        if let range = title.range(of: category) {
            let nsRange = NSRange(range, in: title)
            attributedTitle.addAttributes([
                .font: UIFont.pretendard(.head_b_14)
            ], range: nsRange)
        }
        
        moreButton.setAttributedTitle(attributedTitle, for: .normal)
    }
}
