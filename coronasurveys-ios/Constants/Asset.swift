//
//  Asset.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct Asset {
    static var logo: UIImage? {
        UIImage(named: "logo")
    }

    static var splashScreen: UIImage? {
        UIImage(named: "splash-screen")
    }

    enum Social {
        static var instagram: UIImage? {
            UIImage(named: "instagram")
        }

        static var twitter: UIImage? {
            UIImage(named: "twitter")
        }

        static var facebook: UIImage? {
            UIImage(named: "facebook")
        }
    }
}
