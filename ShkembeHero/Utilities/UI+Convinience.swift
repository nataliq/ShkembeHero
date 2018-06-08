//
//  UI+Convinience.swift
//  ShkembeHero
//
//  Created by Nataliya Patsovska on 2018-06-07.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit

protocol ImageRepresentable {
    var imageRepresentation: UIImage? { get }
}

@discardableResult
func activate(_ constraints: [NSLayoutConstraint]) -> [NSLayoutConstraint] {
    NSLayoutConstraint.activate(constraints)
    return constraints
}

@discardableResult
func activate(_ constraints: NSLayoutConstraint...) -> [NSLayoutConstraint] {
    return activate(constraints)
}

extension UIButton {
    convenience init(title: String, style: ButtonStyle) {
        self.init(type: .custom)
        setTitle(title, for: .normal)

        layer.cornerRadius = style.cornerRadius
        clipsToBounds = true

        setBackgroundImage(style.backgroundColor.asImage(), for: .normal)
        setBackgroundImage(style.backgroundColor.withAlphaComponent(0.7).asImage(), for: .disabled)

        setTitleColor(style.titleStyle.color, for: .normal)
        titleLabel?.font = style.titleStyle.font
        titleLabel?.textAlignment = style.titleStyle.alignment

        if let borderColor = style.borderColor {
            layer.borderWidth = 1.0
            layer.borderColor = borderColor.cgColor
        }
    }
}

extension UILabel {
    convenience init(text: String, style: TextStyle) {
        self.init()
        self.text = text
        applyStyle(style)
    }

    convenience init(attributedText: NSAttributedString, alignment: NSTextAlignment) {
        self.init()
        self.attributedText = attributedText
        textAlignment = alignment
    }

    func applyStyle(_ style: TextStyle) {
        textColor = style.color
        font = style.font
        textAlignment = style.alignment
    }
}

extension UITextField {
    convenience init(style: TextStyle) {
        self.init()
        font = style.font
        textColor = style.color
        textAlignment = style.alignment
    }
}

extension UIBarButtonItem {
    convenience init(title: String) {
        self.init()
        self.title = title
    }
    static var cancel: UIBarButtonItem { return UIBarButtonItem(title: "Cancel") }
}

extension UIColor {
    func asImage() -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        return renderer.image { context in
            set()
            context.cgContext.fill(rect)
        }
    }
}

extension String {
    func attributedHeaderTitle(boldRange: NSRange) -> NSAttributedString {
        let title = NSMutableAttributedString(string: self, attributes: [
            .font: UIFont.header,
            .foregroundColor: UIColor.title,
            .kern: 0.0
            ])
        title.addAttribute(.font, value: UIFont.headerBold, range: boldRange)
        return title
    }
}
