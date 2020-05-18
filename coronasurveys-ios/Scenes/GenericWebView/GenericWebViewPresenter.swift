//
//  GenericWebViewPresenter.swift
//  edenred-iphone
//
//  Created by Josep Bordes Jové on 21/05/2019.
//  Copyright (c) 2019 Inqbarna. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol GenericWebViewPresentationLogic {
    func presentWebView(response: GenericWebView.PrepareWebView.Response)
}

class GenericWebViewPresenter: GenericWebViewPresentationLogic {
    weak var viewController: GenericWebViewDisplayLogic?

    func presentWebView(response: GenericWebView.PrepareWebView.Response) {
        if let urlString = response.urlString, let url = URL(string: urlString) {
            let viewModel = GenericWebView.PrepareWebView.ViewModel(url: url)
            viewController?.displayWebView(viewModel: viewModel)
        }
    }
}
