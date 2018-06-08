//
//  OrderFlow.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/2/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

struct OrderFlow {
    let lastUsedAddress: Address?

    let feelingsScale: Presentation<CustomizeOrder<FeelingsScale>>
    let addAddress: Presentation<CustomizeOrder<Address>>
    let createItem: Presentation<CreateItemFlow>
    let confirmOrder: (Order) -> Presentation<ConfirmOrder>
}

extension OrderFlow: Presentable {
    func materialize() -> (UIViewController, Future<OrderConfirmation>) {
        let viewController = UINavigationController()
        viewController.setNavigationBarHidden(true, animated: false)
        return (viewController,  startWitPresenter(viewController))
    }
}

extension OrderFlow {
    struct DataFlow {
        let lastUsedAddress: Address?
        let showFeelingsScale: () -> FiniteSignal<FeelingsScale>
        let showConfirmOrder: (Order) -> Future<OrderConfirmation>
        let showAddAddress: () -> FiniteSignal<Address>
        let showCreateItem: () -> Future<Order.Item>
    }

    func startWitPresenter(_ presenter: PresentationPresenter) -> Future<OrderConfirmation> {
        /*
         The Data Flow is extracted for testability so that we can check that certain presenter method was called
         and provide a result value. This allows us to simulate a lot of scenarios difficult to reproduce otherwise
         */
        let dataFlow = DataFlow(lastUsedAddress: lastUsedAddress,
                                showFeelingsScale: { presenter.present(self.feelingsScale) },
                                showConfirmOrder: { presenter.present(self.confirmOrder($0)) },
                                showAddAddress: { presenter.present(self.addAddress) },
                                showCreateItem: { presenter.present(self.createItem) })
        return dataFlow.start()
    }
}

extension OrderFlow.DataFlow {
    func start() -> Future<OrderConfirmation> {
        return Future { completion in
            return self.showFeelingsScale()
                .atValue { scale in
                    self.createOrder(forFeelingsScale: scale, lastUsedAddress: self.lastUsedAddress)
                        .flatMap { self.showConfirmOrder($0) }
                        .onValue { completion(.success($0)) }
                }
                .onEnd { completion(.failure(PresentError.dismissed)) }
        }
    }
}

private extension OrderFlow.DataFlow {
    func createOrder(forFeelingsScale scale: FeelingsScale, lastUsedAddress: String?) -> Future<Order> {
        return orderDetails(forFeelingsScale: scale, lastUsedAddress: lastUsedAddress)
            .map { Order(items: [$1], destination: $0) }
    }

    func orderDetails(forFeelingsScale scale: FeelingsScale, lastUsedAddress: String?) -> Future<(Address, Order.Item)> {
        if case .holyMolyHangover = scale {
            return self.quickOrderDetails(prefilledAddress: lastUsedAddress)
        } else {
            return self.orderDetails()
        }
    }

    func quickOrderDetails(prefilledAddress: Address?) -> Future<(Address, Order.Item)> {
        let address: Future<Address>
        if let prefilledAddress = prefilledAddress {
            address = Future(prefilledAddress)
        } else {
            address = showAddAddress().future
        }
        return address.map { ($0, Order.Item.spicyItem) }
    }

    func orderDetails() -> Future<(Address, Order.Item)> {
        return Future<(Address, Order.Item)> { completion in
            let bag = DisposeBag()
            bag += self.showAddAddress()
                .atEnd { completion(.failure(PresentError.dismissed)) }
                .onValueDisposePrevious { address in
                    return self.showCreateItem().onValue { item in
                        completion(.success((address, item)))
                        }.disposable
            }
            return bag
        }
    }
}
