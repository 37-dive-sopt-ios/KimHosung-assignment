//
//  LoginViewController.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.21.
//

import UIKit
import Combine

final class LoginViewController2: UIViewController {
    
    private let rootView = LoginView()
    
    private let loginViewModel = LoginViewModel()
    private var cancellables: Set<AnyCancellable> = Set<AnyCancellable>()
    
    // MARK: - Basic
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideKeyboardWhenTappedAround()
        setupComponentAction()
        setupTextFieldDelegate()
        bind()
    }
    
    private func bind() {
        rootView.emailTextField.textField.textPublisher
            .assign(to: \.value, on: loginViewModel.email)
            .store(in: &cancellables)
        
        rootView.passwordTextField.textField.textPublisher
            .assign(to: \.value, on: loginViewModel.password)
            .store(in: &cancellables)
        
        loginViewModel.isLoginButtonEnabled.sink(receiveValue: { [weak self] isLoginButtonEnabled in
            Log.d("isLoginButtonEnabled: \(isLoginButtonEnabled)")
            self?.rootView.loginButton.backgroundColor = isLoginButtonEnabled ? .baeminMint500 : .baeminGray200
            self?.rootView.loginButton.isEnabled = isLoginButtonEnabled
        })
        .store(in: &cancellables)
    }
    
    // MARK: - Component Action
    private func setupComponentAction() {
        rootView.navigationBackButton.addTarget(self, action: #selector(onClickNavigationBackButton), for: .touchUpInside)
//        rootView.emailTextField.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
//        rootView.passwordTextField.textField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        rootView.loginButton.addTarget(self, action: #selector(onClickLoginButton), for: .touchUpInside)
        rootView.findAccountButton.addTarget(self, action: #selector(onClickFindAccountButton), for: .touchUpInside)
    }
    
    @objc private func onClickNavigationBackButton() {
        Log.d("Back")
    }
    
    @objc private func onClickLoginButton() {
        guard let isValidEmail = rootView.emailTextField.textField.text?.isValidEmail() else { return }
        guard let isValidPassword = rootView.passwordTextField.textField.text?.isValidPassword() else { return }
        
        if isValidEmail && isValidPassword {
            let welcomeViewController = WelcomeViewController()
            welcomeViewController.configure(id: rootView.emailTextField.textField.text, resetLoginViewController: { [weak self] in
                guard let self else { return }
                rootView.emailTextField.textField.text = nil
                rootView.passwordTextField.textField.text = nil
                rootView.emailTextField.setFocused(false)
                rootView.passwordTextField.setFocused(false)
            })
            navigationController?.pushViewController(welcomeViewController, animated: true)
        } else {
            presentInvalidAlert(isValidEmail: isValidEmail, isValidPassword: isValidPassword)
        }
    }
    
    @objc private func editingChanged() {
        let hasText: Bool = !(rootView.emailTextField.textField.text?.isEmpty ?? true) && !(rootView.passwordTextField.textField.text?.isEmpty ?? true)
        rootView.loginButton.backgroundColor = hasText ? .baeminMint500 : .baeminGray200
        rootView.loginButton.isEnabled = hasText
    }
    
    @objc private func onClickFindAccountButton() {
        let findAccountViewController = FindAccountViewController()
        findAccountViewController.modalPresentationStyle = .pageSheet
        if let sheet = findAccountViewController.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
        }
        findAccountViewController.applyEmailToLoginViewController = { [weak self] email in
            self?.rootView.findAccountLabel.text = email
        }
        present(findAccountViewController, animated: true)
    }
    
    // MARK: - Private Function
    private func presentInvalidAlert(isValidEmail: Bool, isValidPassword: Bool) {
        let title: String
        let firstResponder: UITextField
        
        switch (isValidEmail, isValidPassword) {
        case (false, false):
            title = "이메일과 비밀번호 형식이 달라요"
            firstResponder = rootView.emailTextField.textField
        case (false, true):
            title = "이메일 형식이 달라요"
            firstResponder = rootView.emailTextField.textField
        case (true, false):
            title = "비밀번호 형식이 달라요"
            firstResponder = rootView.passwordTextField.textField
        default: return
        }
        
        let alert: UIAlertController = UIAlertController(title: title, message: "", preferredStyle: .alert)
        let action: UIAlertAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
            firstResponder.becomeFirstResponder()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextField Delegate
extension LoginViewController2: UITextFieldDelegate {
    
    private func setupTextFieldDelegate() {
        rootView.emailTextField.textField.delegate = self
        rootView.passwordTextField.textField.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if rootView.emailTextField.textField === textField {
            rootView.emailTextField.setFocused(true)
        } else if rootView.passwordTextField.textField === textField {
            rootView.passwordTextField.setFocused(true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if rootView.emailTextField.textField === textField {
            rootView.emailTextField.setFocused(false)
        } else if rootView.passwordTextField.textField === textField {
            rootView.passwordTextField.setFocused(false)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if rootView.emailTextField.textField === textField {
            rootView.passwordTextField.textField.becomeFirstResponder()
        } else if rootView.passwordTextField.textField === textField {
            rootView.passwordTextField.textField.resignFirstResponder()
        }
        return true
    }
}
