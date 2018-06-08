//
//  ChooseScale.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/2/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

struct ChooseScale<Scale: Equatable> {
    struct Option<Scale> {
        let title: String
        let image: UIImage?
        let value: Scale
    }
    
    let options: [Option<Scale>]
    let current: ReadWriteSignal<Option<Scale>>
    
    init?(options: [Option<Scale>], initial: Scale) {
        self.options = options
        
        guard let initialIndex = options.index(where: { $0.value == initial }) else {
            assertionFailure("The initial value is not part of the provided options")
            return nil
        }
        
        self.current = ReadWriteSignal(options[initialIndex])
    }
}
