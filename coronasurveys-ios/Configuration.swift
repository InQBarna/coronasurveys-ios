//
//  Configuration.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

struct Configuration {
    static let facebookUrl: String = ""
    static let twitterUrl: String = ""
    static let instagramUrl: String = ""
    static let coronaSurveysUrl: String = "https://coronasurveys.org/"
    static let populationSymptomsPlotUrl: String =
        "https://coronasurveys.org/grafana/d-solo/G_Aw4CrZk/coronasurveys?tab=advanced&panelId=20&orgId=1&from=1584576000000"
    static let email: String = "email@example.com"

    static func surveyUrl(countryCode: String) -> String {
        "https://mobile.coronasurveys.org/\(countryCode.lowercased())"
    }
}
