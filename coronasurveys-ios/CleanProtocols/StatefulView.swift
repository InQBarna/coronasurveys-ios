//
//  StatefulView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

enum ViewState {
    case loaded
    case loading
    case error
    case empty
}

protocol StatefulView {
    var viewState: ViewState { get set }
    mutating func updateState(new state: ViewState)
    func prepareForLoaded()
    func prepareForLoading()
    func prepareForError()
    func prepareForEmpty()
}

extension StatefulView {
    mutating func updateState(new state: ViewState) {
        viewState = state

        if let view = self as? UIView {
            view.subviews.forEach { view in
                if var statefullView = view as? StatefulView {
                    statefullView.updateState(new: state)
                } else {
                    view.subviews.forEach { subView in
                        if var statefullView = subView as? StatefulView {
                            statefullView.updateState(new: state)
                        }
                    }
                }
            }
        }

        switch viewState {
        case .loading:
            prepareForLoading()
        case .loaded:
            prepareForLoaded()
        case .error:
            prepareForError()
        case .empty:
            prepareForEmpty()
        }
    }
}
