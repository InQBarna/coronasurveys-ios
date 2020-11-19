//
//  PreferencesStoreProtocol.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation
import UserNotifications

protocol PreferencesStoreProtocol {
    func scheduleNotification(for interval: NotificationInterval)
    func cancelNotification()
    func hasScheduledNotification(completion: @escaping (Bool) -> Void)
    func saveSelectedCountry(_ country: String)
    func retrieveSelectedCountry() -> String?
    func saveSelectedLanguage(_ language: String)
    func retrieveSelectedLanguage() -> String?
    func notificationsAuthStatus(completion: @escaping (UNAuthorizationStatus) -> Void)
}
