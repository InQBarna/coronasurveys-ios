//
//  SplashScreenInteractor.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright (c) 2020 Inqbarna. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashScreenBusinessLogic {
    func prepareView(request: SplashScreen.PrepareView.Request)
}

protocol SplashScreenDataStore: DependencyInjectable {
    // var name: String { get set }
}

class SplashScreenInteractor: SplashScreenBusinessLogic, SplashScreenDataStore {
    var presenter: SplashScreenPresentationLogic?

    // MARK: Data store

    var context: [Dependency: Any?]?

    // MARK: Business logic

    func prepareView(request: SplashScreen.PrepareView.Request) {
        let response = SplashScreen.PrepareView.Response()
        presenter?.presentView(response: response)
    }
}
