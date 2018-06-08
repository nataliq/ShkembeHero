//
//  FeelingsScale.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/3/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit

enum FeelingsScale: String {
    case noWay = "No Way"
    case soSo = "So - so"
    case littleHeadache = "Little Headache"
    case holyMolyHangover = "Holy Moly.. Hungover!"
}

extension FeelingsScale: CaseIterable {
    static var allCases: [FeelingsScale] {
        return [.noWay, .soSo, .littleHeadache, .holyMolyHangover]
    }
}
    
extension FeelingsScale: CustomStringConvertible { }

extension FeelingsScale: ImageRepresentable {
    var imageRepresentation: UIImage? {
        switch self {
        case .noWay: return #imageLiteral(resourceName: "happy")
        case .soSo: return #imageLiteral(resourceName: "okay")
        case .littleHeadache: return #imageLiteral(resourceName: "hmm")
        case .holyMolyHangover: return #imageLiteral(resourceName: "dead")
        }
    }
}
