//
//  WebViewCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit
import WebKit

class WebViewCell: UITableViewCell, CellIdentifier {
    // MARK: UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.smaltBlue
        label.font = .font(.headline6)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var webKitView: WKWebView = {
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController = WKUserContentController()
        userContentController.addUserScript(script)

        let webConfig = WKWebViewConfiguration()
        webConfig.dataDetectorTypes = .all
        webConfig.userContentController = userContentController

        let webView = WKWebView(frame: .zero, configuration: webConfig)
        webView.isMultipleTouchEnabled = false
        webView.contentMode = .scaleAspectFit
        webView.scrollView.isScrollEnabled = false
        webView.translatesAutoresizingMaskIntoConstraints = false

        return webView
    }()

    // MARK: Object lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    public func setup(with title: String?, url: String?) {
        titleLabel.text = title
        titleLabel.numberOfLines = 0

        if let urlRaw = url, let url = URL(string: urlRaw) {
            let request = URLRequest(url: url)
            webKitView.load(request)
        }
    }

    private func setupView() {
        selectionStyle = .none
        [titleLabel, webKitView].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            webKitView.heightAnchor.constraint(equalToConstant: 380),
            webKitView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            webKitView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            webKitView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            webKitView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
