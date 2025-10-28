//
//  UIFont+.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.21.
//

import Foundation
import UIKit

enum PretendardWeight: String {
    case black      = "Black"
    case extraBold  = "ExtraBold"
    case bold       = "Bold"
    case semiBold   = "SemiBold"
    case medium     = "Medium"
    case regular    = "Regular"
    case light      = "Light"
    case extraLight = "ExtraLight"
    case thin       = "Thin"
    
    var name: String {
        return "Pretendard-\(rawValue)"
    }
}

extension UIFont {
    static func pretendard(_ weight: PretendardWeight = .regular, size fontSize: CGFloat) -> UIFont? {
        return UIFont(name: weight.name, size: fontSize)
    }
}
