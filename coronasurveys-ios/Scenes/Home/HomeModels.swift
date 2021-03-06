//
//  HomeModels.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright (c) 2020 Inqbarna. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Home {
    // MARK: Use cases

    enum PrepareView {
        struct Request {}

        struct Response {
            let countryCode: String?
        }

        struct ViewModel {
            let title: String
            let countryCode: String?
            let sections: [HomeContent]
        }
    }

    enum UpdateCountryCode {
        struct Request {
            let newCountryCode: String?
        }

        struct Response {
            let countryCode: String?
        }

        struct ViewModel {
            let countryCode: String?
        }
    }
}
