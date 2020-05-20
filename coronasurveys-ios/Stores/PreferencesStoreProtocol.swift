//
//  PreferencesStoreProtocol.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

protocol PreferencesStoreProtocol {
    func scheduleNotification(for interval: NotificationInterval)
    func cancelNotification()
    func hasScheduledNotification(completion: @escaping (Bool) -> Void)
}
