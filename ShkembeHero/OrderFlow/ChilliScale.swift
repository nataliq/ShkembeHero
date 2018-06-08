//
//  ChilliScale.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit

//
//  GarlicScale.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit

enum ChilliScale: String {
    case none = "No thanks"
    case little = "A little bit"
    case lots = "Lots!"
}

extension ChilliScale: CaseIterable {
    static var allCases: [ChilliScale] {
        return [.none, .little, .lots]
    }
}

extension ChilliScale: CustomStringConvertible { }

extension ChilliScale: ImageRepresentable {
    var imageRepresentation: UIImage? {
        switch self {
        case .none: return #imageLiteral(resourceName: "noChilli")
        case .little: return #imageLiteral(resourceName: "chilli")
        case .lots: return #imageLiteral(resourceName: "fire")
        }
    }
}
