//
//  PreferencesWorker.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

class PreferencesWorker: PreferencesStoreProtocol {
    private let store: PreferencesStoreProtocol

    public init(store: PreferencesStoreProtocol) {
        self.store = store
    }

    func scheduleNotification(for interval: NotificationInterval) {
        store.scheduleNotification(for: interval)
    }

    func cancelNotification() {
        store.cancelNotification()
    }

    func hasScheduledNotification(completion: @escaping (Bool) -> Void) {
        store.hasScheduledNotification(completion: completion)
    }
}
