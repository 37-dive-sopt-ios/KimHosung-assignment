//
//  BaseViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.07.
//

import UIKit

final class BaseViewController: UITabBarController {
    
    private let homeViewController = HomeViewController()
    private let shoppingViewController = UIViewController()
    private let wishlistViewController = UIViewController()
    private let orderHistoryViewController = UIViewController()
    private let mypageViewController = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shoppingViewController.view.backgroundColor = .red
        wishlistViewController.view.backgroundColor = .yellow
        orderHistoryViewController.view.backgroundColor = .green
        mypageViewController.view.backgroundColor = .blue
        
        viewControllers = [
            homeViewController,
            shoppingViewController,
            wishlistViewController,
            orderHistoryViewController,
            mypageViewController,
        ]
        
        guard let tabBarItems = tabBar.items else { return }
        
        tabBarItems[0].title = "홈"
        tabBarItems[1].title = "장보기·쇼핑"
        tabBarItems[2].title = "찜"
        tabBarItems[3].title = "주문내역"
        tabBarItems[4].title = "마이배민"
        
        tabBarItems[0].image = UIImage(resource: .homeFill) // TODO: temp homefill
        tabBarItems[1].image = UIImage(resource: .shopping)
        tabBarItems[2].image = UIImage(resource: .wishlist)
        tabBarItems[3].image = UIImage(resource: .orderHistory)
        tabBarItems[4].image = UIImage(resource: .mybaemin)
        
        tabBarItems[0].selectedImage = UIImage(resource: .homeFill)
//        tabBarItems[1].selectedImage = UIImage(resource: <#T##ImageResource#>)
//        tabBarItems[2].selectedImage = UIImage(resource: <#T##ImageResource#>)
//        tabBarItems[3].selectedImage = UIImage(resource: <#T##ImageResource#>)
//        tabBarItems[4].selectedImage = UIImage(resource: <#T##ImageResource#>)
        
        selectedIndex = 0
        
        tabBar.tintColor = .baeminBlack
        tabBar.unselectedItemTintColor = .baeminBlack
        tabBar.backgroundColor = .baeminWhite
        
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOpacity = 0.05
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowRadius = 4
        
        tabBar.itemPositioning = .centered
    }
}
