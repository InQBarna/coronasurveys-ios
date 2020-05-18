//
//  UIFont.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

public extension UIFont {
    enum Font {
        case regular
        case semiBold
        case extraLight
        case medium
        case bold
        case light

        var weight: Weight {
            switch self {
            case .regular:
                return .regular
            case .semiBold:
                return .semibold
            case .extraLight:
                return .ultraLight
            case .medium:
                return .medium
            case .bold:
                return .bold
            case .light:
                return .light
            }
        }
    }

    enum FontStyle {
        case headline4
        case headline5
        case headline6
        case subtitle1
        case subtitle2
        case body1
        case body2
        case body3
        case button
        case buttonCancel
        case caption
        case overline

        var style: TextStyle {
            switch self {
            case .headline4:
                if #available(iOS 11.0, *) {
                    return .largeTitle
                } else {
                    return .title1
                }
            case .headline5:
                return .title1
            case .headline6:
                return .title3
            case .subtitle1:
                return .headline
            case .subtitle2:
                return .subheadline
            case .body1, .body3:
                return .body
            case .body2, .button, .buttonCancel:
                return .callout
            case .caption:
                return .caption1
            case .overline:
                return .caption2
            }
        }

        var font: Font {
            switch self {
            case .headline4, .headline5:
                return .medium
            case .headline6:
                return .semiBold
            case .subtitle1:
                return .medium
            case .subtitle2:
                return .semiBold
            case .body3:
                return .bold
            case .body1, .body2:
                return .medium
            case .button:
                return .semiBold
            case .buttonCancel:
                return .bold
            case .caption:
                return .medium
            case .overline:
                return .semiBold
            }
        }
    }

    private static func font(of textStyle: TextStyle, with font: Font) -> UIFont {
        let desc = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)

        if #available(iOS 11.0, *) {
            let metrics = UIFontMetrics(forTextStyle: textStyle)
            let appliedfont = UIFont.systemFont(ofSize: desc.pointSize, weight: font.weight)
            return metrics.scaledFont(for: appliedfont)
        } else {
            let appliedfont = UIFont.systemFont(ofSize: desc.pointSize, weight: font.weight)
            return appliedfont
        }
    }

    static func font(_ easyBuyFont: FontStyle) -> UIFont {
        .font(of: easyBuyFont.style, with: easyBuyFont.font)
    }
}
