//
//  Router.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

class Router: NSObject {
    var window: UIWindow?

    // MARK: Object lifecycle

    init(window: UIWindow?) {
        self.window = window
        super.init()

        configureInitialRootViewController()
    }

    private func configureInitialRootViewController() {
        defer {
            window?.makeKeyAndVisible()
        }

        guard NSClassFromString("XCTest") == nil else {
            window?.rootViewController = UISplitViewController()
            return
        }

        routeToSplash(context: nil)
    }

    // MARK: Routes

    public func routeToSplash(context: [Dependency: Any?]?) {
        let splashViewController = SplashScreenViewController()
        var splashDataStore = splashViewController.router!.dataStore!
        splashDataStore.context = context ?? generateInitialContext()
        window?.rootViewController = splashViewController
    }

    public func routeToHome(context: [Dependency: Any?]?) {
        let homeViewController = HomeViewController()
        var homeDataStore = homeViewController.router!.dataStore!
        homeDataStore.context = context ?? generateInitialContext()

        let navigationController = UINavigationController(rootViewController: homeViewController)
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = false
        }
        navigationController.navigationBar.tintColor = Color.black
        window?.rootViewController = navigationController
    }

    // MARK: Helpers

    private func generateInitialContext() -> [Dependency: Any?]? {
        [
            .router: self
        ]
    }
}
