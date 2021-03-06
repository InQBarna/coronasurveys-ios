//
//  GenericWebViewModels.swift
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
import WebKit

enum GenericWebView {
    // MARK: Use cases

    enum PrepareWebView {
        struct Request {
            let shouldReloadProducts: Bool
        }

        struct Response {
            let urlString: String?
        }

        struct ViewModel {
            let url: URL
        }
    }
}
