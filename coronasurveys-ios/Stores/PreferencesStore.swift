//
//  PreferencesStore.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation
import UserNotifications

class PreferencesStore: PreferencesStoreProtocol {
    private enum Constants {
        static let notificationIdentifier: String = "SurveyReminder"
    }

    func hasScheduledNotification(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                completion(requests.count > 0)
            }
        }
    }

    func scheduleNotification(for interval: NotificationInterval) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = L10N.reminderNotificationTitle
        content.subtitle = L10N.reminderNotificationBody
        content.sound = UNNotificationSound.default

        // show this notification intervalSeconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval.intervalSeconds, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: Constants.notificationIdentifier, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }

    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }

    func notificationsAuthStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }

    func saveSelectedCountry(_ country: String) {
        UserDefaults.standard.set(country, forKey: UserDefaultsConstants.savedCountry)
    }

    func retrieveSelectedCountry() -> String? {
        let savedCountry = UserDefaults.standard.string(forKey: UserDefaultsConstants.savedCountry)
        return savedCountry
    }

    func saveSelectedLanguage(_ language: String) {
        UserDefaults.standard.set(language, forKey: UserDefaultsConstants.savedLanguage)
    }

    func retrieveSelectedLanguage() -> String? {
        let language = UserDefaults.standard.string(forKey: UserDefaultsConstants.savedLanguage)
        return language
    }
}
