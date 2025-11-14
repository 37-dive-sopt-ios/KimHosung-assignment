//
//  Int+.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.13.
//

import Foundation

extension Int {
    func toFormattedString() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}
