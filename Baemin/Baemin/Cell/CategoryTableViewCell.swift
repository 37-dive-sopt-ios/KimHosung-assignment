//
//  CategoryTableViewCell.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.08.
//

import SnapKit

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    
    // MARK: - Enum
    enum TabBarCategory: Int, CaseIterable {
        case delivery
        case pickup
        case shopping
        case gift
        case bonus
        
        var title: String {
            switch self {
            case .delivery:
                return "음식배달"
            case .pickup:
                return "픽업"
            case .shopping:
                return "장보기·쇼핑"
            case .gift:
                return "선물하기"
            case .bonus:
                return "혜택모아보기"
            }
        }
    }
    
    // MARK: - Property
    private var tabBarIndex: Int = 0
    private var pageViewControllers: [UIViewController] = []
    
    // MARK: - Component
    let backgroundGradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.colors = [.baeminBackgroundWhite, UIColor(rgb: 0xC9F9F0)]
        gradientView.locations = [0, 1]
        gradientView.startPoint = .init(x: 0.5, y: 0)
        gradientView.endPoint = .init(x: 0.5, y: 1)
        return gradientView
    }()
    
    let bmartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .bmartTitle)
        return imageView
    }()
    
    let titleButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.attributedTitle = AttributedString("전상품 쿠폰팩 + 60%특가", attributes: AttributeContainer([
            .font: UIFont.pretendard(.head_b_16)
        ]))
        configuration.image = UIImage(resource: .chevronRight)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 2
        configuration.titleAlignment = .leading
        configuration.contentInsets = .zero
        
        button.configuration = configuration
        button.tintColor = .baeminBlack
        return button
    }()
    
    let tabBarCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .baeminWhite
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset.left = 16
        collectionView.contentInset.right = 16
        collectionView.decelerationRate = .fast
        collectionView.layer.cornerRadius = 10
        collectionView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        collectionView.layer.applyShadow(color: UIColor(rgb: 0x28B8B3), alpha: 0.25, blur: 4, spread: 0, y: -4)
        
        return collectionView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminGray200
        return view
    }()
    
    let mainPageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return pageViewController
    }()
    
    let selectedUnderBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBlack
        return view
    }()
    
    // MARK: - Basic
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupPageViewControllers()
        setupTabBar()
        setupComponentAction()
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
    
    private func setupPageViewControllers() {
        TabBarCategory.allCases.forEach({ tabBarCategory in
            let categoryViewController = CategoryViewController()
            categoryViewController.configure(tabBarCategory: tabBarCategory)
            pageViewControllers.append(categoryViewController)
        })
    }
    
    private func setupTabBar() {
        mainPageViewController.delegate = self
        mainPageViewController.dataSource = self
        
        tabBarCollectionView.register(TabBarIndexCollectionViewCell.self)
        tabBarCollectionView.delegate = self
        tabBarCollectionView.dataSource = self
        
        mainPageViewController.setViewControllers([pageViewControllers[0]], direction: .forward, animated: false, completion: nil)
        layoutIfNeeded()
        updateSelectedUnderBarViewConstraints(indexPath: IndexPath(item: tabBarIndex, section: 0))
        tabBarCollectionView.selectItem(at: IndexPath(item: tabBarIndex, section: 0), animated: false, scrollPosition: [])
    }
    
    private func setupComponentAction() {
        titleButton.addTarget(self, action: #selector(onClickTitleButton), for: .touchUpInside)
    }
    
    private func setupHierarchy() {
        contentView.addSubviews(
            backgroundGradientView,
            tabBarCollectionView,
            separatorView,
            mainPageViewController.view,
            selectedUnderBarView,
        )
        backgroundGradientView.addSubviews(
            bmartImageView,
            titleButton,
        )
    }
    
    private func setupLayout() {
        backgroundGradientView.snp.makeConstraints({
            $0.top.horizontalEdges.equalToSuperview()
        })
        bmartImageView.snp.makeConstraints({
            $0.top.equalToSuperview().inset(14)
            $0.leading.equalToSuperview().inset(16)
            $0.width.equalTo(50)
            $0.height.equalTo(16)
        })
        titleButton.snp.makeConstraints({
            $0.top.equalTo(bmartImageView.snp.bottom).offset(6)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(37)
        })
        tabBarCollectionView.snp.makeConstraints({
            $0.top.equalTo(backgroundGradientView.snp.bottom).offset(-10)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(48)
        })
        separatorView.snp.makeConstraints({
            $0.top.equalTo(tabBarCollectionView.snp.bottom)
            $0.bottom.equalTo(mainPageViewController.view.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
        })
        mainPageViewController.view.snp.makeConstraints({
            $0.top.equalTo(separatorView.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(238)
        })
        selectedUnderBarView.snp.makeConstraints({
            $0.bottom.equalTo(tabBarCollectionView.snp.bottom)
            $0.height.equalTo(3)
        })
    }
    
    // MARK: - Component Action
    @objc private func onClickTitleButton() {
        Log.d("onClickTitleButton")
    }
    
    // MARK: - Private Function
    private func updateSelectedUnderBarViewConstraints(indexPath: IndexPath) {
        guard let cell = tabBarCollectionView.cellForItem(at: indexPath) else { return }
        selectedUnderBarView.snp.remakeConstraints({
            $0.bottom.equalTo(tabBarCollectionView.snp.bottom)
            $0.height.equalTo(3)
            $0.horizontalEdges.equalTo(cell)
        })
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension CategoryTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TabBarCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarIndexCollectionViewCell.identifier, for: indexPath) as? TabBarIndexCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let tabBarCategory = TabBarCategory(rawValue: indexPath.item) else {
            Log.e("IndexPath Item is out of range: \(indexPath)")
            return cell
        }
        cell.titleLabel.text = tabBarCategory.title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != tabBarIndex else { return }
        mainPageViewController.setViewControllers([pageViewControllers[indexPath.item]], direction: tabBarIndex < indexPath.item ? .forward : .reverse, animated: true, completion: nil)
        tabBarIndex = indexPath.item
        UIView.animate(withDuration: 0.2, animations: { [weak self] in
            guard let self else { return }
            updateSelectedUnderBarViewConstraints(indexPath: indexPath)
            layoutIfNeeded()
        })
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

// MARK: - UIPageViewController Delegate & DataSource
extension CategoryTableViewCell: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewControllers = pageViewController.viewControllers,
              let currentIndex = pageViewControllers.firstIndex(of: viewControllers[0]) else { return }
        
        tabBarIndex = currentIndex
        let indexPath = IndexPath(item: currentIndex, section: 0)
        
        tabBarCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            guard let self else { return }
            updateSelectedUnderBarViewConstraints(indexPath: indexPath)
            layoutIfNeeded()
        })
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageViewControllers.firstIndex(of: viewController) else { return nil }
        guard currentIndex > 0 else { return nil }
        let newIndex = currentIndex - 1
        return pageViewControllers[newIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pageViewControllers.firstIndex(of: viewController) else { return nil }
        guard currentIndex < TabBarCategory.allCases.count - 1 else { return nil }
        let newIndex = currentIndex + 1
        return pageViewControllers[newIndex]
    }
}
