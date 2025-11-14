//
//  SearchTextField.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.08.
//

import UIKit

final class SearchTextField: UITextField {
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(resource: .search), for: .normal)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addLeftPadding(17)
        rightView = searchButton
        rightViewMode = .always
        
        backgroundColor = .baeminWhite
        layer.borderColor = UIColor.baeminBlack.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 20
        
        spellCheckingType = .no
        autocapitalizationType = .none
        autocorrectionType = .no
        inlinePredictionType = .no
        smartDashesType = .no
        smartQuotesType = .no
        smartInsertDeleteType = .no
    }
    
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= 17
        return padding
    }
}
