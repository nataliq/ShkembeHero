//
//  AddAddress.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

// Ideally should be a type
typealias Address = String

struct AddAddress {
    let hint: String
    let validation: (String) -> Bool
    let validText: ReadWriteSignal<String?> = ReadWriteSignal(nil)
}

extension AddAddress: Presentable {
    func materialize() -> (UIView, Disposable) {
        let view = UIView()

        let field = UITextField(style: .secondaryAction)
        field.placeholder = hint

        view.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false

        activate(
            field.topAnchor.constraint(equalTo: view.topAnchor),
            field.leftAnchor.constraint(equalTo: view.leftAnchor),
            field.rightAnchor.constraint(equalTo: view.rightAnchor)
        )

        let bag = DisposeBag()
        bag += field
            .filter(predicate: validation)
            .onValue { self.validText.value = $0 }

        return (view, bag)
    }
}
