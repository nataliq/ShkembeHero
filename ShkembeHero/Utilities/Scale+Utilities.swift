//
//  Utilities.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/2/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Foundation

protocol CaseIterable {
    associatedtype AllCases: Collection where AllCases.Element == Self
    static var allCases: AllCases { get }
}

extension RawRepresentable where RawValue == String, Self: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}

extension ChooseScale where Scale: CaseIterable & CustomStringConvertible {
    init?(initial: Scale) {
        let options = Scale.allCases.map { value in
            return ChooseScale.Option(title: value.description,
                                      image: (value as? ImageRepresentable)?.imageRepresentation,
                                      value: value)
        }
        self.init(options: options, initial: initial)
    }
}
