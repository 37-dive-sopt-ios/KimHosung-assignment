//
//  FindAccountView.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.07.
//

import SnapKit

import UIKit

final class FindAccountView: UIView {
    
    // MARK: - Component
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일을 입력해주세요"
        label.font = .pretendard(.title_sb_18)
        return label
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .baeminWhite
        textField.layer.cornerRadius = 3
        textField.addLeftPadding(22)
        textField.clearButtonMode = .whileEditing
        textField.spellCheckingType = .no
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.inlinePredictionType = .no
        textField.smartDashesType = .no
        textField.smartQuotesType = .no
        textField.smartInsertDeleteType = .no
        return textField
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.isEnabled = false
        button.backgroundColor = .baeminGray200
        button.setTitleColor(.baeminWhite, for: .normal)
        button.setTitle("확인", for: .normal)
        button.layer.cornerRadius = 4
        button.titleLabel?.font = .pretendard(.head_b_18)
        return button
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
        backgroundColor = .baeminGray300
        setupHierarchy()
        setupLayout()
    }
    
    private func setupHierarchy() {
        addSubviews(
            titleLabel,
            emailTextField,
            okButton,
        )
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints({
            $0.top.equalToSuperview().inset(33)
            $0.leading.equalToSuperview().inset(17)
        })
        emailTextField.snp.makeConstraints({
            $0.top.equalTo(titleLabel.snp.bottom).offset(33)
            $0.leading.equalToSuperview().inset(17)
            $0.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(46)
        })
        okButton.snp.makeConstraints({
            $0.bottom.equalToSuperview().inset(38)
            $0.leading.equalToSuperview().inset(24)
            $0.trailing.equalToSuperview().inset(22)
            $0.height.equalTo(46)
        })
    }
}
