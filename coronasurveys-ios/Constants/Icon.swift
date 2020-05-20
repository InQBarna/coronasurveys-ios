//
//  Icon.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct Icon {
    static var settings: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "gear")
        } else {
            return UIImage(named: "settings")
        }
    }

    static var chevronRight: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "chevron.right")
        } else {
            return UIImage(named: "settings")
        }
    }

    static var xmark: UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: "xmark")
        } else {
            return UIImage(named: "xmark")
        }
    }
}
