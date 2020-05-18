//
//  GenericWebViewView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit
import WebKit

struct GenericWebViewViewVM: Equatable {
    let url: URL?
}

class GenericWebViewView: UIView, CleanView {
    typealias VMType = GenericWebViewViewVM

    static var emptySkeleton: GenericWebViewViewVM = GenericWebViewViewVM(url: nil)
    var viewModel: GenericWebViewViewVM = GenericWebViewView.emptySkeleton
    var viewState: ViewState = .empty

    weak var delegate: WKNavigationDelegate? {
        get {
            webKitView.navigationDelegate
        }
        set {
            webKitView.navigationDelegate = newValue
        }
    }

    // MARK: UI

    private lazy var webKitView: WKWebView = {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        userContentController.addUserScript(script)

        let webConfig = WKWebViewConfiguration()
        webConfig.dataDetectorTypes = .all
        webConfig.userContentController = userContentController

        let webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.isMultipleTouchEnabled = false
        webView.contentMode = .scaleAspectFit
        webView.translatesAutoresizingMaskIntoConstraints = false

        return webView
    }()

    // MARK: Object lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setupConstraints()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    private func setupView() {
        backgroundColor = Color.white
        [webKitView].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            webKitView.topAnchor.constraint(equalTo: topAnchor),
            webKitView.leftAnchor.constraint(equalTo: leftAnchor),
            webKitView.bottomAnchor.constraint(equalTo: bottomAnchor),
            webKitView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    // MARK: Clean view

    func display(viewModel: GenericWebViewViewVM) {
        self.viewModel = viewModel

        if let url = viewModel.url {
            let request = URLRequest(url: url)
            webKitView.load(request)
        }
    }

    // MARK: Stateful view

    func prepareForLoaded() {}

    func prepareForLoading() {}

    func prepareForError() {}

    func prepareForEmpty() {}
}
