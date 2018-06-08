//
//  Order.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Foundation

struct Order {
    struct Item {
        let garlic: GarlicScale
        let chilli: ChilliScale
    }
    let items: [Item]
    let destination: Address
}
