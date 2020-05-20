//
//  HomeContent.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

struct Institution: Equatable {
    let imageUrl: URL?
    let name: String
}

enum SocialNetwork: Equatable {
    case facebook(URL?)
    case twitter(URL?)
    case instagram(URL?)
}

enum HomeContent: Equatable {
    case summary(text: String)
    case supportedBy(institutions: [Institution])
    case about(String?)
    case webViewPlot(title: String, url: String?)
    case followUs(institutions: [SocialNetwork])
    case contactUs
}
