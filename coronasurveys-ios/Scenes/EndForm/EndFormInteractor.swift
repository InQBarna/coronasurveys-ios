//
//  EndFormInteractor.swift
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

protocol EndFormBusinessLogic {
    func prepareView(request: EndForm.PrepareView.Request)
}

protocol EndFormDataStore: DependencyInjectable {
    // var name: String { get set }
}

class EndFormInteractor: EndFormBusinessLogic, EndFormDataStore {
    var presenter: EndFormPresentationLogic?

    // MARK: Data store

    var context: [Dependency: Any?]?

    // MARK: PrepareView

    func prepareView(request: EndForm.PrepareView.Request) {
        let response = EndForm.PrepareView.Response()
        presenter?.presentView(response: response)
    }
}