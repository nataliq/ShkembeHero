//
//  Styling.swift
//  ShkembeHero
//
//  Created by Nataliya  on 6/3/18.
//  Copyright © 2018 nataliya_bg. All rights reserved.
//

import UIKit

// Color palette
extension UIColor {
    static let tint = UIColor(red: 3.0 / 255.0, green: 134.0 / 255.0, blue: 170.0 / 255.0, alpha: 1.0)
    static let background = UIColor.white
    static let title = UIColor(white: 0.0, alpha: 1.0)
    static let primaryActionText = UIColor(white: 1.0, alpha: 1.0)
    static let primaryActionBackground = UIColor.tint
    static let secondaryActionText = primaryActionBackground
    static let secondaryActionBackground = primaryActionText
}

// Sample text styles
extension UIFont {
//    static let header = UIFont.systemFont(ofSize: 24.0, weight: .regular)
    
    static var logo: UIFont {
        let font = UIFont(name: "HelveticaNeue-Light", size: 50)!
        let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var logoBold: UIFont {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 50)!
        let fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var header: UIFont {
        let font = UIFont(name: "HelveticaNeue-Light", size: 30.0)!
        let fontMetrics = UIFontMetrics(forTextStyle: .title1)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var headerBold: UIFont {
        let font = UIFont(name: "HelveticaNeue-Medium", size: 30.0)!
        let fontMetrics = UIFontMetrics(forTextStyle: .title1)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var primaryActionText: UIFont {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 17)!
        let fontMetrics = UIFontMetrics(forTextStyle: .title2)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var secondaryActionText: UIFont {
        let font = UIFont(name: "HelveticaNeue-Medium", size: 17)!
        let fontMetrics = UIFontMetrics(forTextStyle: .title2)
        return fontMetrics.scaledFont(for: font)
    }
}

struct TextStyle {
    let font: UIFont
    let color: UIColor
    let alignment: NSTextAlignment
}

extension TextStyle {
    static let primaryAction = TextStyle(font: .primaryActionText, color: .primaryActionText, alignment: .center)
    static let secondaryAction = TextStyle(font: .secondaryActionText, color: .secondaryActionText, alignment: .center)
}

struct ButtonStyle {
    let titleStyle: TextStyle
    let backgroundColor: UIColor
    let borderColor: UIColor?
    let cornerRadius: CGFloat
    
    init(titleStyle: TextStyle, backgroundColor: UIColor, borderColor: UIColor? = nil, cornerRadius: CGFloat = 0.0) {
        self.titleStyle = titleStyle
        self.backgroundColor = backgroundColor
        self.borderColor = borderColor
        self.cornerRadius = cornerRadius
    }
}

extension ButtonStyle {
    static let primaryAction = ButtonStyle(titleStyle: .primaryAction, backgroundColor: .primaryActionBackground, cornerRadius: 10)
    static let secondaryAction = ButtonStyle(titleStyle: .secondaryAction, backgroundColor: .secondaryActionBackground, borderColor: .secondaryActionText, cornerRadius: 10)
}
