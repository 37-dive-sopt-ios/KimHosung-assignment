//
//  HomeView.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.05.
//

import SnapKit

import UIKit

final class HomeView: UIView {
    
    // MARK: - Component
    let topBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBackgroundWhite
        return view
    }()
    
    let topBarContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let locationButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.attributedTitle = AttributedString("우리집", attributes: AttributeContainer([
            .font: UIFont.pretendard(.head_b_16)
        ]))
        configuration.image = UIImage(resource: .expand)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 3
        configuration.titleAlignment = .center
        
        button.configuration = configuration
        button.tintColor = .baeminBlack
        
        return button
    }()
    
    let topBarRightButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let benefitButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .benefit), for: .normal)
        return button
    }()
    
    let notificationButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .notification), for: .normal)
        return button
    }()
    
    let shopButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .shop), for: .normal)
        return button
    }()
    
    let searchBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .baeminBackgroundWhite
        return view
    }()
    
    let searchBarTextField: SearchTextField = {
        let textField = SearchTextField()
        textField.font = .pretendard(.body_r_14)
        textField.attributedPlaceholder = NSAttributedString(string: "찾아라! 맛있는 음식과 맛집", attributes: [.foregroundColor: UIColor.baeminGray300])
        return textField
    }()
    
    let mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = .baeminBackgroundWhite
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.keyboardDismissMode = .interactive
        return tableView
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
        backgroundColor = .baeminBackgroundWhite
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        addSubviews(
            mainTableView,
            topBarView,
            searchBarView,
        )
        topBarView.addSubview(topBarContainerView)
        topBarContainerView.addSubviews(
            locationButton,
            topBarRightButtonsStackView,
        )
        topBarRightButtonsStackView.addArrangedSubviews(
            benefitButton,
            notificationButton,
            shopButton,
        )
        searchBarView.addSubview(searchBarTextField)
    }
    
    private func setupLayout() {
        topBarView.snp.makeConstraints({
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(33)
        })
        topBarContainerView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
        searchBarView.snp.makeConstraints({
            $0.top.equalTo(topBarView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(60)
        })
        mainTableView.snp.makeConstraints({
            $0.edges.equalTo(safeAreaLayoutGuide)
        })
        locationButton.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        })
        topBarRightButtonsStackView.snp.makeConstraints({
            $0.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalToSuperview().inset(9)
        })
        benefitButton.snp.makeConstraints({
            $0.size.equalTo(24)
        })
        notificationButton.snp.makeConstraints({
            $0.size.equalTo(24)
        })
        shopButton.snp.makeConstraints({
            $0.size.equalTo(24)
        })
        searchBarTextField.snp.makeConstraints({
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
    }
    
    // MARK: - Global Function
    func updateTopBarViewYPosition(_ y: CGFloat) {
        topBarView.snp.updateConstraints({
            $0.top.equalTo(safeAreaLayoutGuide).offset(y)
        })
    }
}
