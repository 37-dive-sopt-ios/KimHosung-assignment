//
//  DiscountMarketModel.swift
//  Baemin
//
//  Created by 김호성 on 2025.11.14.
//

import UIKit

struct DiscountMarketModel {
    enum Badge {
        case baeminClub
        case custom(String)
    }
    
    let image: UIImage
    let marketName: String
    let rating: Float
    let ratingCount: Int
    let deliveryTime: ClosedRange<Int>
    let isDeliveryFree: Bool
    let badges: [Badge]
}
