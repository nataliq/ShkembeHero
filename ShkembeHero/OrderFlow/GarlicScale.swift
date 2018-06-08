//
//  GarlicScale.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit

enum GarlicScale: String {
    case none = "No garlic today"
    case little = "A little bit"
    case lots = "All the garlic, please!"
}

extension GarlicScale: CaseIterable {
    static var allCases: [GarlicScale] {
        return [.none, .little, .lots]
    }
}

extension GarlicScale: CustomStringConvertible { }

extension GarlicScale: ImageRepresentable {
    var imageRepresentation: UIImage? {
        switch self {
        case .none: return #imageLiteral(resourceName: "noGarlic")
        case .little: return #imageLiteral(resourceName: "littleGarlic")
        case .lots: return #imageLiteral(resourceName: "lotsOfGarlic")
        }
    }
}
