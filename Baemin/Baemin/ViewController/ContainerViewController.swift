//
//  BaseViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.07.
//

import UIKit

final class ContainerViewController: UITabBarController {
    
    private let homeViewController = HomeViewController()
    private let networkViewController = NetworkViewController()
    private let wishlistViewController = UIViewController()
    private let orderHistoryViewController = UIViewController()
    private let mypageViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wishlistViewController.view.backgroundColor = .yellow
        orderHistoryViewController.view.backgroundColor = .green
        mypageViewController.view.backgroundColor = .blue
        
        viewControllers = [
            homeViewController,
            networkViewController,
            wishlistViewController,
            orderHistoryViewController,
            mypageViewController,
        ]
        
        setupTabBar()
    }
    
    func setupTabBar() {
        homeViewController.tabBarItem = UITabBarItem(title: "홈", image: .homeFill, tag: 1)
        networkViewController.tabBarItem = UITabBarItem(title: "장보기·쇼핑", image: .shopping, tag: 2)
        wishlistViewController.tabBarItem = UITabBarItem(title: "찜", image: .wishlist, tag: 3)
        orderHistoryViewController.tabBarItem = UITabBarItem(title: "주문내역", image: .orderHistory, tag: 4)
        mypageViewController.tabBarItem = UITabBarItem(title: "마이배민", image: .mybaemin, tag: 4)
        
        setupTabBarAppearance()
    }

    func setupTabBarAppearance() {
        let barAppearance = UITabBarAppearance()
        
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = .baeminWhite
        
        barAppearance.stackedLayoutAppearance.normal.iconColor = .baeminGray700
        barAppearance.stackedLayoutAppearance.selected.iconColor = .baeminBlack
        barAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .font: UIFont.pretendard(.title_sb_10),
            .foregroundColor: UIColor.baeminGray700
        ]
        barAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .font: UIFont.pretendard(.title_sb_10),
            .foregroundColor: UIColor.baeminBlack
        ]
        
        tabBar.standardAppearance = barAppearance
        tabBar.scrollEdgeAppearance = barAppearance
        
        tabBar.layer.shadowColor = UIColor.baeminBlack.cgColor
        tabBar.layer.shadowOpacity = 0.05
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 31
    }
}
