//
//  CellIdentifier.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

protocol CellIdentifier {
    static var identifier: String { get }
}

extension CellIdentifier {
    static var identifier: String {
        String(describing: self)
    }
}
