//
//  NotificationInterval.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

enum NotificationInterval {
    case daily
    case weekly

    var intervalSeconds: Double {
        switch self {
        case .weekly:
            return 7 * 24 * 3600
        case .daily:
            return 24 * 3600
        }
    }
}
