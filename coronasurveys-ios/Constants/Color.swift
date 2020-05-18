//
//  Color.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct Color {
    static var smaltBlue: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "smalt-blue")
        } else {
            return UIColor(red: 0.286, green: 0.545, blue: 0.569, alpha: 1)
        }
    }

    static var violetBlue: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "smalt-blue")
        } else {
            return UIColor(red: 0.431, green: 0.322, blue: 0.718, alpha: 1)
        }
    }

    // MARK: Status

    static var correct: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "correct")
        } else {
            return UIColor(red: 0.311, green: 0.670, blue: 0.394, alpha: 1)
        }
    }

    static var warning: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "warning")
        } else {
            return UIColor(red: 0.957, green: 0.616, blue: 0.431, alpha: 1)
        }
    }

    static var wrong: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "wrong")
        } else {
            return UIColor(red: 0.957, green: 0, blue: 0.176, alpha: 1)
        }
    }

    // MARK: Gray scale

    static var white: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "1-white")
        } else {
            return UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }

    static var lightGray: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "2-light-gray")
        } else {
            return UIColor(red: 0.937, green: 0.937, blue: 0.937, alpha: 1)
        }
    }

    static var midGray: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "3-mid-gray")
        } else {
            return UIColor(red: 0.702, green: 0.706, blue: 0.729, alpha: 1)
        }
    }

    static var darkGray: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "4-mid-gray")
        } else {
            return UIColor(red: 0.498, green: 0.498, blue: 0.502, alpha: 1)
        }
    }

    static var black: UIColor? {
        if #available(iOS 11.0, *) {
            return UIColor(named: "5-black")
        } else {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
