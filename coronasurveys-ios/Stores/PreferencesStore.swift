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
    private struct Constants {
        static let notificationIdentifier: String = "SurveyReminder"
    }

    func hasScheduledNotification(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                print(requests)
                completion(requests.count > 0)
            }
        }
    }

    func scheduleNotification(for interval: NotificationInterval) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("reminder_survey", comment: "")
        content.subtitle = NSLocalizedString("reminder_survey_body", comment: "")
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: interval.intervalSeconds, repeats: true)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: Constants.notificationIdentifier, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }

    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}
