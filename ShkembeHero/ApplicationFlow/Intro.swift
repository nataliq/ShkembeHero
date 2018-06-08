//
//  Intro.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/3/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import Flow
import Presentation

struct Intro {
    let order: ReadWriteSignal<()> = ReadWriteSignal(())
}

extension Intro: Presentable {
    func materialize() -> (UIViewController, Disposable) {
        let viewController = UIViewController()
        
        let content = UIView()
        content.backgroundColor = .background
        
        let order = UIButton(title: "Give it to me", style: .primaryAction)
        
        let inspiration = UIImageView(image: UIImage(named: "Inspiration"))
        
        let inspirationText = UILabel(attributedText: attributedLogo, alignment: .center)
        
        viewController.view = content
        
        [inspiration, order, inspirationText].forEach { view in
            content.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let constraints: [NSLayoutConstraint] = [
            inspiration.leftAnchor.constraint(equalTo: content.leftAnchor),
            inspiration.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            inspiration.topAnchor.constraint(equalTo: content.topAnchor),
            inspirationText.topAnchor.constraint(equalTo: inspiration.topAnchor, constant: 48),
            inspirationText.centerXAnchor.constraint(equalTo: inspiration.centerXAnchor),
            inspiration.bottomAnchor.constraint(equalTo: order.topAnchor),
            order.heightAnchor.constraint(equalToConstant: 60),
            order.leftAnchor.constraint(equalTo: content.leftAnchor, constant: 40),
            order.centerXAnchor.constraint(equalTo: inspiration.centerXAnchor),
            order.bottomAnchor.constraint(equalTo: content.bottomAnchor, constant: -63)
        ]
        activate(constraints)

        let disposable = order.onValue {
            self.order.value = ()
        }
        return (viewController, disposable)
    }
    
    private var attributedLogo: NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "ShkembeHero!", attributes: [
            .font: UIFont.logo,
            .foregroundColor: UIColor.primaryActionText
        ])
        attributedString.addAttribute(.font, value: UIFont.logoBold, range: NSRange(location: 7, length: 4))
        return attributedString
    }
}
