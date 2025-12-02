//
//  UITextField+.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.22.
//

import UIKit
import Combine

extension UITextField {
    
    var textPublisher: AnyPublisher<String?, Never> {
        NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: self)
            .map({ output in
                let textField = output.object as? UITextField
                return textField?.text
            })
            .eraseToAnyPublisher()
    }
    
    func addLeftPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    
    func addRightPadding(_ padding: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightView = paddingView
        rightViewMode = .always
    }
}
