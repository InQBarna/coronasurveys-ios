//
//  CleanView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import Foundation

protocol CleanView: StatefulView {
    associatedtype VMType: Equatable
    var viewModel: VMType { get }
    static var emptySkeleton: VMType { get }
    func display(viewModel: VMType)
}

extension CleanView {
    func cleanPresenterOutput(updateUI: Bool = false) -> ((VMType) -> Void) {
        return { newViewModel in
            guard !updateUI else {
                return self.display(viewModel: newViewModel)
            }
            guard newViewModel != self.viewModel else {
                return
            }
            self.display(viewModel: newViewModel)
            assert(self.viewModel == newViewModel, "You forgot to assign new viewmodel to view vm getter \(newViewModel)")
        }
    }
}
