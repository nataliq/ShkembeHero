//
//  CustomizeScale.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/3/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

struct CustomizeOrder<OutputConfiguration> {
    let preview: AnyPresentable<UIView, Disposable>
    let headerTitle: NSAttributedString
    let completionTitle: String
    let currentValue: ReadSignal<OutputConfiguration?>
}

extension CustomizeOrder: Presentable {
    func materialize() -> (UIViewController, FiniteSignal<OutputConfiguration>) {
        let viewController = UIViewController()
        
        let content = UIView()
        content.backgroundColor = .background
        viewController.view = content
        
        let header = UILabel(attributedText: headerTitle, alignment: .center)
        let (preview, previewDisposable) = self.preview.materialize()
        
        let cancel = UIButton(title: "Back", style: .secondaryAction)
        let complete = UIButton(title: completionTitle, style: .primaryAction)
        let buttonsStack = UIStackView(arrangedSubviews: [cancel, complete])
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 13
        
        [preview, header, buttonsStack].forEach { view in
            content.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints: [NSLayoutConstraint] = [
            header.topAnchor.constraint(equalTo: content.topAnchor, constant: 84),
            header.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            preview.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 100),
            preview.leftAnchor.constraint(equalTo: content.leftAnchor),
            preview.rightAnchor.constraint(equalTo: content.rightAnchor),
            preview.bottomAnchor.constraint(equalTo: buttonsStack.topAnchor, constant: -69),
            buttonsStack.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 33),
            buttonsStack.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            buttonsStack.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -63),
            buttonsStack.heightAnchor.constraint(equalToConstant: 60)
        ]
        activate(constraints)
        
        let bag = DisposeBag()
        bag += previewDisposable
        
        return (viewController, FiniteSignal<OutputConfiguration> { callback in
            bag += self.currentValue.atOnce().map { $0 != nil }.bindTo(complete, \.isEnabled)
            bag += cancel.onValue { callback(.end(nil)) }
            bag += complete.onValue { _ in
                callback(.value(self.currentValue.value!)) }
            return bag
        })
    }
}
