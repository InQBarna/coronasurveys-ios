//
//  Dependency.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

enum Dependency {
    case router
}

extension Dictionary where Key == Dependency, Value == Any? {
    var router: Router? {
        get {
            self[.router] as? Router
        }
        set {
            self[.router] = newValue
        }
    }
}

// MARK: DependencyInjectable

protocol DependencyInjectable {
    var context: [Dependency: Any?]? { get set }
}

// MARK: AutoUpdateContext

protocol AutoUpdateContext {
    var childrenViewControllers: [UIViewController]? { get }
    var context: [Dependency: Any?]? { get set }
}
