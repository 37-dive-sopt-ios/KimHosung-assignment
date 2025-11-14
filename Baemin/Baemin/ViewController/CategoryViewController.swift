//
//  CategoryViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.11.
//

import UIKit

final class CategoryViewController: UIViewController {
    
    private let rootView = CategoryView()
    
    // MARK: - Struct
    private struct CategoryMenuModel {
        var title: String
        var image: UIImage?
    }
    
    // MARK: - Property
    private var tabBarCategory: CategoryTableViewCell.TabBarCategory?
    private var categoryMenuModels: [CategoryMenuModel] = []
    
    // MARK: - Basic
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.moreButton.addTarget(self, action: #selector(onClickMoreButton), for: .touchUpInside)
        
        rootView.mainCollectionView.register(CategoryCollectionViewCell.self)
        rootView.mainCollectionView.delegate = self
        rootView.mainCollectionView.dataSource = self
    }
    
    // MARK: - Configure
    func configure(tabBarCategory: CategoryTableViewCell.TabBarCategory) {
        self.tabBarCategory = tabBarCategory
        rootView.setmoreButtonTitle(tabBarCategory.title)
        switch tabBarCategory {
        case .delivery:
            categoryMenuModels = [
                CategoryMenuModel(title: "한그릇", image: .oneBowl),
                CategoryMenuModel(title: "치킨", image: .chicken),
                CategoryMenuModel(title: "카페·디저트", image: .dessert),
                CategoryMenuModel(title: "피자", image: .pizza),
                CategoryMenuModel(title: "분식", image: .bunsik),
                CategoryMenuModel(title: "고기", image: .meat),
                CategoryMenuModel(title: "찜·탕", image: .soup),
                CategoryMenuModel(title: "야식", image: .nightMeal),
                CategoryMenuModel(title: "패스트푸드", image: .fastfood),
                CategoryMenuModel(title: "픽업", image: .pickup),
            ]
        default:
            categoryMenuModels = [
                CategoryMenuModel(title: "한그릇"),
                CategoryMenuModel(title: "치킨"),
                CategoryMenuModel(title: "카페·디저트"),
                CategoryMenuModel(title: "피자"),
                CategoryMenuModel(title: "분식"),
                CategoryMenuModel(title: "고기"),
                CategoryMenuModel(title: "찜·탕"),
                CategoryMenuModel(title: "야식"),
                CategoryMenuModel(title: "패스트푸드"),
                CategoryMenuModel(title: "픽업"),
            ]
        }
    }
    
    // MARK: - Component Action
    @objc private func onClickMoreButton() {
        Log.d("onClickMoreButton")
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension CategoryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryMenuModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.titleLabel.text = categoryMenuModels[indexPath.item].title
        cell.mainImageView.image = categoryMenuModels[indexPath.item].image
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Log.d(indexPath.item)
    }
}
