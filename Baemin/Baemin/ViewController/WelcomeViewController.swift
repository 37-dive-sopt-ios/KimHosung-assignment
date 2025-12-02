//
//  WelcomeViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.26.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    private let rootView = WelcomeView()
    
    // MARK: - Property
    private var id: String?
    private var resetLoginViewController: (() -> Void)?
    
    // MARK: - Basic
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentAction()
    }
    
    // MARK: - Configure
    func configure(id: String?, resetLoginViewController: (() -> Void)?) {
        self.id = id
        rootView.subWelcomeLabel.text = "\(id ?? "")님 반가워요!"
        self.resetLoginViewController = resetLoginViewController
    }
    
    // MARK: - Setup
    private func setupComponentAction() {
        rootView.navigationBackButton.addTarget(self, action: #selector(onClickNavigationBackButton), for: .touchUpInside)
        rootView.mainButton.addTarget(self, action: #selector(onClickMainButton), for: .touchUpInside)
    }
    
    // MARK: - Component Action
    @objc private func onClickNavigationBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func onClickMainButton() {
        resetLoginViewController?()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        sceneDelegate.replaceRootViewController(with: BaseViewController())
    }
}
