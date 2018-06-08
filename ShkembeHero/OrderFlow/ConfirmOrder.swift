//
//  ConfirmOrder.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

// very hardcoded stuff, mainly for demo purposes
struct OrderConfirmation {
    let message: String
}

struct ConfirmOrder {
    let order: Order
}

extension ConfirmOrder: Presentable {
    func materialize() -> (UIViewController, Future<OrderConfirmation>) {
        let viewController = UIViewController()

        let confirmationText = """
        Thank you for ordering with ShkembeHero!
        You will soon get \(order.items.count) amazing shkembe delivered to \(order.destination)
        """

        let content = UILabel(text: confirmationText, style: .secondaryAction)
        content.numberOfLines = 0
        content.backgroundColor = .background
        viewController.view = content
        
        return (viewController, Future { completion in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                completion(.success(OrderConfirmation(message: "Coming soon!")))
            }
            return NilDisposer()
        })
    }
}
