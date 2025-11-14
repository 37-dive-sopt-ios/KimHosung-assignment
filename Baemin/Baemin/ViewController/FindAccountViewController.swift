//
//  FindAccountViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.28.
//

import UIKit

final class FindAccountViewController: UIViewController {
    
    private let rootView = FindAccountView()
    
    // MARK: - Property
    var applyEmailToLoginViewController: ((String?) -> Void)?
    
    // MARK: - Basic
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupComponentAction()
    }
    
    // MARK: - Setup
    private func setupComponentAction() {
        rootView.emailTextField.addTarget(self, action: #selector(editingChangedEmailTextField), for: .editingChanged)
        rootView.okButton.addTarget(self, action: #selector(onClickOkButton), for: .touchUpInside)
    }
    
    // MARK: - Component Action
    @objc private func editingChangedEmailTextField(_ sender: UITextField) {
        let hasText: Bool = !(sender.text?.isEmpty ?? true)
        rootView.okButton.isEnabled = hasText
        rootView.okButton.backgroundColor = hasText ? .baeminMint500 : .baeminGray200
    }
    @objc private func onClickOkButton() {
        applyEmailToLoginViewController?(rootView.emailTextField.text)
        dismiss(animated: true)
    }
}
