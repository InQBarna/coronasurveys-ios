//
//  Configuration.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

struct Configuration {
    static let teamUrl: String = "https://coronasurveys.org/team"
    static let dataUrl: String = "https://github.com/GCGImdea/coronasurveys/tree/master/data/"
    static let facebookUrl: String = "https://www.facebook.com/coronasurveys/"
    static let twitterUrl: String = "https://twitter.com/coronasurveys"
    static let instagramUrl: String = "https://www.instagram.com/coronasurveys/"

    static var populationSymptomsPlotUrl: String {
        "https://coronasurveys.org/grafana/d-solo/G_Aw4CrZk/coronasurveys?tab=advanced&panelId=20&orgId=1&from=1584576000000"
    }

    static let email: String = "coronasurveys@gmail.com"

    static func surveyUrl(countryCode: String, languageCode: String) -> String {
        #if DEBUG
            return "https://mobile.coronasurveys.org/?r=survey/index&sid=991378"
        #else
            return "https://mobile.coronasurveys.org/\(countryCode.lowercased())/\(languageCode.lowercased())"
        #endif
    }
}
