//
//  HomeViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.05.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let rootView = HomeView()
    
    // MARK: - Enum
    private enum ScrollDirection {
        case up
        case down
        
        init?(velocity: CGFloat) {
            if velocity > 0 {
                self = .up
            } else {
                self = .down
            }
        }
    }
    
    // MARK: - Property
    private var offsetCorrection: CGFloat = 0
    
    // MARK: - Basic
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupMainTableView()
        setupComponentAction()
    }
    
    // MARK: - Setup
    private func setupMainTableView() {
        rootView.mainTableView.register(CategoryTableViewCell.self)
        rootView.mainTableView.register(MarketTableViewCell.self)
        rootView.mainTableView.register(AdvertisementTableViewCell.self)
        rootView.mainTableView.register(RankingTableViewCell.self)
        rootView.mainTableView.register(RecentTableViewCell.self)
        rootView.mainTableView.register(DiscountTableViewCell.self)
        
        rootView.mainTableView.delegate = self
        rootView.mainTableView.dataSource = self
        
        rootView.mainTableView.panGestureRecognizer.addTarget(self, action: #selector(panGesture))
        
        rootView.layoutIfNeeded()
        rootView.mainTableView.contentInset.top = rootView.topBarView.bounds.height + rootView.searchBarView.bounds.height
        rootView.mainTableView.contentOffset.y = -rootView.mainTableView.contentInset.top
        
        rootView.mainTableView.refreshControl = UIRefreshControl()
        rootView.mainTableView.refreshControl?.addTarget(self, action: #selector(mainTableViewRefreshed), for: .valueChanged)
    }
    
    private func setupComponentAction() {
        rootView.locationButton.addTarget(self, action: #selector(onClickLocationButton), for: .touchUpInside)
        rootView.benefitButton.addTarget(self, action: #selector(onClickBenefitButton), for: .touchUpInside)
        rootView.notificationButton.addTarget(self, action: #selector(onClickNotificationButton), for: .touchUpInside)
        rootView.shopButton.addTarget(self, action: #selector(onClickShopButton), for: .touchUpInside)
    }
    
    // MARK: - Component Action
    @objc func onClickLocationButton() {
        Log.d("onClickLocationButton")
    }
    
    @objc func onClickBenefitButton() {
        Log.d("onClickBenefitButton")
    }
    
    @objc func onClickNotificationButton() {
        Log.d("onClickNotificationButton")
    }
    
    @objc func onClickShopButton() {
        Log.d("onClickShopButton")
    }
    
    @objc func mainTableViewRefreshed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: { [weak self] in
            guard let self else { return }
            rootView.mainTableView.refreshControl?.beginRefreshing()
            sleep(1)
            rootView.mainTableView.reloadData()
            rootView.mainTableView.refreshControl?.endRefreshing()
        })
    }
    
    @objc func panGesture(_ sender: UIPanGestureRecognizer) {
        // Adjust the accumulated scroll translation
        // so that the topBarView responds immediately when the scroll direction changes
        let translationY = sender.translation(in: rootView.mainTableView).y
        let velocityY = sender.velocity(in: rootView.mainTableView).y
        
        let unclampedOffset = translationY - offsetCorrection
        
        // Update offsetCorrection value
        if unclampedOffset >= 0 {
            // When topBarView is visible
            // topBarViewOffsetY = translationY - offsetCorrection = 0
            offsetCorrection = translationY
        }
        if unclampedOffset <= -rootView.topBarView.bounds.height {
            // When topBarView is hidden
            // topBarViewOffsetY = translationY - offsetCorrection = -rootView.topBarView.bounds.height
            offsetCorrection = translationY + rootView.topBarView.bounds.height
        }
        
        let topBarViewOffsetY = translationY - offsetCorrection
        rootView.updateTopBarViewYPosition(topBarViewOffsetY)
        rootView.topBarContainerView.alpha = 1 + topBarViewOffsetY / rootView.topBarView.bounds.height
        
        // Magnetic snapping effect when the gesture ends
        if sender.state == .ended {
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                guard let self else { return }
                switch ScrollDirection(velocity: velocityY) {
                case .up:
                    rootView.updateTopBarViewYPosition(0)
                    offsetCorrection = 0
                    rootView.topBarContainerView.alpha = 1
                case .down:
                    rootView.updateTopBarViewYPosition(-rootView.topBarView.bounds.height)
                    offsetCorrection = rootView.topBarView.bounds.height
                    rootView.topBarContainerView.alpha = 0
                case nil:
                    break
                }
                rootView.layoutIfNeeded()
            })
        }
    }
}

// MARK: - UITableView Delegate & DataSource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum MainTableViewSection: Int, CaseIterable {
        case category
        case market
        case advertisement
        case ranking
        case recent
        case discount
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return MainTableViewSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = MainTableViewSection(rawValue: indexPath.section) else {
            Log.e("IndexPath Section is out of range: \(indexPath)")
            return UITableViewCell()
        }
        
        switch section {
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as? CategoryTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .market:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as? MarketTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .advertisement:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AdvertisementTableViewCell.identifier, for: indexPath) as? AdvertisementTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .ranking:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RankingTableViewCell.identifier, for: indexPath) as? RankingTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .recent:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecentTableViewCell.identifier, for: indexPath) as? RecentTableViewCell else {
                return UITableViewCell()
            }
            return cell
        case .discount:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DiscountTableViewCell.identifier, for: indexPath) as? DiscountTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
    }
}
