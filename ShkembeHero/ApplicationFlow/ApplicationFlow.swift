//
//  Application.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/2/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

struct ApplicationFlow {
    let intro: Presentation<Intro>
    let orderFlow: Presentation<OrderFlow>
    let triggerOrderFlow: Signal<()>
}

extension ApplicationFlow {
    init() {
        intro = Presentation(Intro())
        triggerOrderFlow = intro.presentable.order.plain()
        orderFlow = Presentation(OrderFlow(lastUsedAddress: "Betahaus Sofia"), style: .modal)
    }
}

extension ApplicationFlow: Presentable {
    func materialize() -> (UIViewController, Disposable) {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        
        let bag = DisposeBag()
        bag += viewController.present(intro)
        bag += triggerOrderFlow.onValue {
            viewController.present(self.orderFlow)
        }
        return (viewController, bag)
    }
}
