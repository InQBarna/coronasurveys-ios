//
//  HomeContent.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

enum HomeContent: Equatable {
    case summary(text: String)
    case about(String?)
    case webViewPlot(title: String, url: String?)
    case followUs(institutions: [SocialNetwork])
    case contactUs
}
