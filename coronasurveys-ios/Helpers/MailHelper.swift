//
//  MailHelper.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

enum MailApps {
    case mail(recipient: String, subject: String, body: String?)
    case gmail(recipient: String, subject: String, body: String?)
    case outlook(recipient: String, subject: String, body: String?)

    static func allAvailable(recipient: String, subject: String, body: String?) -> [MailApps] {
        var available: [MailApps] = []

        if UIApplication.shared.canOpenURL(MailApps.mail(recipient: recipient, subject: subject, body: body).urlScheme) {
            available.append(.mail(recipient: recipient, subject: subject, body: body))
        }

        if UIApplication.shared.canOpenURL(MailApps.gmail(recipient: recipient, subject: subject, body: body).urlScheme) {
            available.append(.gmail(recipient: recipient, subject: subject, body: body))
        }

        if UIApplication.shared.canOpenURL(MailApps.outlook(recipient: recipient, subject: subject, body: body).urlScheme) {
            available.append(.outlook(recipient: recipient, subject: subject, body: body))
        }

        return available
    }

    var title: String {
        switch self {
        case .mail:
            return L10N.mailApp
        case .gmail:
            return L10N.gmailApp
        case .outlook:
            return L10N.outlookApp
        }
    }

    var urlScheme: URL {
        switch self {
        case let .mail(recipient, subject, body):
            return openMailScheme(to: recipient, with: subject, body: body)
        case let .gmail(recipient, subject, body):
            return openGmailScheme(to: recipient, with: subject, body: body)
        case let .outlook(recipient, subject, body):
            return openOutlookScheme(to: recipient, with: subject, body: body)
        }
    }

    private func openGmailScheme(to recipient: String, with subject: String?, body: String?) -> URL {
        let parameters: [String: Any?] = [
            "to": recipient,
            "subject": subject,
            "body": body
        ]

        return generateUrl(scheme: "googlegmail", path: "/co/", queryItems: parameters)
    }

    private func openMailScheme(to recipient: String, with subject: String?, body: String?) -> URL {
        let parameters: [String: Any?] = [
            "to": recipient,
            "subject": subject,
            "body": body
        ]

        return generateUrl(scheme: "mailto", path: nil, queryItems: parameters)
    }

    private func openOutlookScheme(to recipient: String, with subject: String?, body: String?) -> URL {
        let parameters: [String: Any?] = [
            "to": recipient,
            "subject": subject,
            "body": body
        ]

        return generateUrl(scheme: "ms-outlook", path: "/compose/", queryItems: parameters)
    }

    private func generateUrl(scheme: String, path: String?, queryItems: [String: Any?]) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        if let path = path {
            urlComponents.path = path
        }
        urlComponents.queryItems = queryItems.compactMap {
            if let value = $0.value {
                return URLQueryItem(name: $0.key, value: "\(value)")
            }
            return nil
        }

        return urlComponents.url.unsafelyUnwrapped
    }
}

class MailLinker: UIAlertController {
    private let availableApps: [MailApps]
    private weak var sender: UIView?

    init(availableApps: [MailApps], sender: UIView?) {
        self.availableApps = availableApps
        self.sender = sender
        super.init(nibName: nil, bundle: nil)

        if availableApps.count > 0 {
            setupForMailClientPicker()
        } else {
            setupForErrorAlert()
        }

        if let popoverController = popoverPresentationController, let sender = sender {
            popoverController.sourceView = self.sender
            popoverController.sourceRect = CGRect(x: sender.bounds.midX, y: sender.bounds.midY, width: 0, height: 0)
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupForMailClientPicker() {
        title = L10N.selectMailApp

        var actions: [UIAlertAction] = availableApps.compactMap { (mailApp) -> UIAlertAction? in
            if !UIApplication.shared.canOpenURL(mailApp.urlScheme) {
                return nil
            }
            return UIAlertAction(title: mailApp.title, style: .default, handler: { _ in
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(mailApp.urlScheme, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(mailApp.urlScheme)
                }
            })
        }

        actions.append(UIAlertAction(title: L10N.cancel, style: .cancel, handler: nil))
        actions.forEach { addAction($0) }
    }

    private func setupForErrorAlert() {
        title = L10N.noMailAppsAvailable
        addAction(UIAlertAction(title: L10N.cancel, style: .cancel, handler: nil))
    }
}
