//
//  Presenters.swift
//  ShkembeHero
//
//  Created by Nataliya Patsovska on 2018-06-06.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

protocol PresentablePresenter {
    func present<P: Presentable>(_ presentable: P, style: PresentationStyle, options: PresentationOptions, configure: @escaping (P.Matter, DisposeBag) -> ()) -> Future<()> where P.Matter: UIViewController, P.Result == Disposable

    func present<P: Presentable, Value>(_ presentable: P, style: PresentationStyle, options: PresentationOptions, configure: @escaping (P.Matter, DisposeBag) -> ()) -> Future<Value> where P.Matter: UIViewController, P.Result == Future<Value>

    func present<P: Presentable, S: SignalProvider, Value>(_ presentable: P, style: PresentationStyle, options: PresentationOptions, configure: @escaping (P.Matter, DisposeBag) -> ()) -> FiniteSignal<Value> where P.Matter: UIViewController, P.Result == S, S.Value == Value
}

protocol PresentationPresenter {
    func present<P>(_ presentation: Presentation<P>) -> Future<()> where P.Result == Disposable
    func present<P, Value>(_ presentation: Presentation<P>) -> Future<Value> where P.Result == Future<Value>
    func present<P, S: SignalProvider, Value>(_ p: Presentation<P>) -> FiniteSignal<Value> where P.Result == S, S.Value == Value
}

extension UIViewController: PresentablePresenter, PresentationPresenter { }
