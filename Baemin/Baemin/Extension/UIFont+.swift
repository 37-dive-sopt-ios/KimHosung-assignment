//
//  UIFont+.swift
//  Baemin
//
//  Created by 김호성 on 2025.10.21.
//

import UIKit

extension UIFont {
    
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

    enum PretendardStyle {
        
        case head_b_24
        case head_b_18
        case head_b_16
        case head_b_14
        case head_b_13
        
        case title_sb_18
        case title_sb_14
        case title_sb_10
        
        case body_r_14
        case body_r_13
        case body_r_12
        case body_r_10
        
        case caption_r_10
        
        private var weight: PretendardWeight {
            switch self {
            case .head_b_24, .head_b_18, .head_b_16, .head_b_14, .head_b_13:
                return .bold
            case .title_sb_18, .title_sb_14, .title_sb_10:
                return .semiBold
            case .body_r_14, .body_r_13, .body_r_12, .body_r_10, .caption_r_10:
                return .regular
            }
        }
        var name: String {
            return weight.name
        }
        var size: CGFloat {
            switch self {
            case .head_b_24:
                return 24
            case .head_b_18, .title_sb_18:
                return 18
            case .head_b_16:
                return 16
            case .head_b_14, .title_sb_14, .body_r_14:
                return 14
            case .head_b_13, .body_r_13:
                return 13
            case .body_r_12:
                return 12
            case .title_sb_10, .body_r_10, .caption_r_10:
                return 10
            }
        }
    }
    
    static func pretendard(_ weight: PretendardWeight = .regular, size fontSize: CGFloat) -> UIFont? {
        return UIFont(name: weight.name, size: fontSize)
    }
    
    static func pretendard(_ style: PretendardStyle) -> UIFont? {
        return UIFont(name: style.name, size: style.size)
    }
}
