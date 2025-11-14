//
//  Float+.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import Foundation

extension Float {
    func toString(decimalPlace: Int) -> String {
        return String(format: "%.\(decimalPlace)f", self)
    }
}
