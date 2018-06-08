//
//  OrderFlow+ApplicationContext.swift
//  ShkembeHero
//
//  Created by Nataliya Patsovska on 2018-06-07.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

extension OrderFlow {
    init(lastUsedAddress: Address? = nil) {
        self.lastUsedAddress = lastUsedAddress

        let feelingsTitle = "How are you today?"
            .attributedHeaderTitle(boldRange: NSRange(location: 12, length: 5))

        let chooser = ChooseScale<FeelingsScale>(initial: .soSo)!
        feelingsScale = Presentation(CustomizeOrder(preview: AnyPresentable(chooser),
                                                    headerTitle: feelingsTitle,
                                                    completionTitle: "Next",
                                                    currentValue: chooser.current.map { $0.value }))

        let addressField = AddAddress(hint: "Start typing an address", validation: { $0.count >= 5 })
        let addAddress = CustomizeOrder<String>(preview: AnyPresentable(addressField),
                                                headerTitle: "Where To?".attributedHeaderTitle(boldRange: NSRange(location: 6, length: 2)),
                                                completionTitle: "Next",
                                                currentValue: addressField.validText.map { $0 })

        self.addAddress = Presentation(addAddress, options: .autoPop)
        createItem = Presentation(CreateItemFlow(), options: .autoPop)
        confirmOrder = { Presentation(ConfirmOrder(order: $0)) }
    }
}

extension Order.Item {
    static let spicyItem = Order.Item(garlic: .lots, chilli: .lots)
}

extension CreateItemFlow {
    init() {
        let garlicScaleChooser = ChooseScale<GarlicScale>(initial: .little)!
        garlicScale = CustomizeOrder(preview: AnyPresentable(garlicScaleChooser),
                                     headerTitle: "How much Garlic? 🧛🏻‍♂️".attributedHeaderTitle(boldRange: NSRange(location: 9, length: 6)),
                                     completionTitle: "Next",
                                     currentValue: garlicScaleChooser.current.map { $0.value })

        let chilliScaleChooser = ChooseScale<ChilliScale>(initial: .little)!
        chilliScale = CustomizeOrder(preview: AnyPresentable(chilliScaleChooser),
                                     headerTitle: "How much Chilli? 🌶".attributedHeaderTitle(boldRange: NSRange(location: 9, length: 6)),
                                     completionTitle: "Next",
                                     currentValue: chilliScaleChooser.current.map { $0.value })
    }
}
