//
//  CreateItemFlow.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/5/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

struct CreateItemFlow {
    let garlicScale: CustomizeOrder<GarlicScale>
    let chilliScale: CustomizeOrder<ChilliScale>
}

extension CreateItemFlow: Presentable {
    func materialize() -> (UIViewController, Future<Order.Item>) {
        let (viewController, garlicScaleResult) = garlicScale.materialize()
        
        return (viewController, Future<Order.Item> { completion in
            let bag = DisposeBag()
            bag += garlicScaleResult.atValue { garlicScale in
                let innerBag = DisposeBag()
                innerBag += viewController.present(Presentation(self.chilliScale, options: .autoPop)).atValue { chilliScale in
                    let item = Order.Item(garlic: garlicScale, chilli: chilliScale)
                    completion(.success(item))
                }.onEnd {
                    innerBag.dispose()
                }
            }.onEnd {
                completion(.failure(PresentError.dismissed))
            }
            return bag
        })
    }
}
