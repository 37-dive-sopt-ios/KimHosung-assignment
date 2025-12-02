//
//  LoginView.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.07.
//

import SnapKit

import UIKit

final class LoginView: UIView {
    
    // MARK: - Component
    let navigationBarView: UIView = {
        let view = UIView()
        return view
    }()
    
    let navigationBackButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .arrowLeft), for: .normal)
        return button
    }()
    
    let navigationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일 또는 아이디로 계속"
        label.textColor = .baeminBlack
        label.font = .pretendard(.title_sb_18)
        return label
    }()
    
    let inputStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let emailTextField: AnimatedTextField = {
        let animatedTextField = AnimatedTextField()
        
        animatedTextField.configure(placeholder: "이메일 또는 아이디를 입력해 주세요", animatedPlaceholder: "이메일 아이디")
        
        animatedTextField.textField.tintColor = .baeminMint300 // caret
        animatedTextField.textField.clearButtonMode = .whileEditing
        animatedTextField.textField.keyboardType = .emailAddress
        animatedTextField.textField.spellCheckingType = .no
        animatedTextField.textField.autocapitalizationType = .none
        animatedTextField.textField.autocorrectionType = .no
        animatedTextField.textField.inlinePredictionType = .no
        animatedTextField.textField.smartDashesType = .no
        animatedTextField.textField.smartQuotesType = .no
        animatedTextField.textField.smartInsertDeleteType = .no
        
        return animatedTextField
    }()
    
    let passwordTextField: AnimatedTextField = {
        let animatedTextField = AnimatedTextField()
        
        animatedTextField.configure(placeholder: "비밀번호를 입력해 주세요", animatedPlaceholder: "비밀번호")
        animatedTextField.addSecurityButton()
        
        animatedTextField.textField.tintColor = .baeminMint300 // caret
        animatedTextField.textField.returnKeyType = .done
        animatedTextField.textField.clearButtonMode = .whileEditing
        animatedTextField.textField.spellCheckingType = .no
        animatedTextField.textField.autocapitalizationType = .none
        animatedTextField.textField.autocorrectionType = .no
        animatedTextField.textField.inlinePredictionType = .no
        animatedTextField.textField.smartDashesType = .no
        animatedTextField.textField.smartQuotesType = .no
        animatedTextField.textField.smartInsertDeleteType = .no
        animatedTextField.textField.isSecureTextEntry = true
        
        return animatedTextField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = .baeminGray200
        button.setTitleColor(.baeminWhite, for: .normal)
        button.setTitle("로그인", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .pretendard(.head_b_18)
        return button
    }()
    
    let findAccountButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        
        configuration.attributedTitle = AttributedString("계정 찾기", attributes: AttributeContainer([
            .font: UIFont.pretendard(.body_r_14)
        ]))
        configuration.image = UIImage(resource: .chevronRight)
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
        configuration.titleAlignment = .center
        
        button.configuration = configuration
        button.tintColor = .baeminBlack
        
        return button
    }()
    
    let findAccountLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .pretendard(.body_r_14)
        return label
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
            navigationBarView,
            inputStackView,
            loginButton,
            findAccountButton,
            findAccountLabel,
        )
        
        navigationBarView.addSubviews(
            navigationBackButton,
            navigationTitleLabel,
        )
        
        inputStackView.addArrangedSubviews(
            emailTextField,
            passwordTextField,
        )
    }
    
    private func setupLayout() {
        navigationBarView.snp.makeConstraints({
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(42)
        })
        navigationBackButton.snp.makeConstraints({
            $0.leading.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(36)
        })
        navigationTitleLabel.snp.makeConstraints({
            $0.center.equalToSuperview()
        })
        inputStackView.snp.makeConstraints({
            $0.top.equalTo(navigationBarView.snp.bottom).offset(24)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
        emailTextField.snp.makeConstraints({
            $0.height.equalTo(46)
        })
        passwordTextField.snp.makeConstraints({
            $0.height.equalTo(46)
        })
        loginButton.snp.makeConstraints({
            $0.height.equalTo(46)
            $0.top.equalTo(inputStackView.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(16)
        })
        findAccountButton.snp.makeConstraints({
            $0.top.equalTo(loginButton.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        })
        findAccountLabel.snp.makeConstraints({
            $0.top.equalTo(findAccountButton.snp.bottom).offset(38)
            $0.centerX.equalToSuperview()
        })
    }
}
