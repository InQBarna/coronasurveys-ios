//
//  HomeTableHandler.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol HomeTableHandlerDelegate: AnyObject {
    func didTapSeeTeamButton()
    func didTapSeeDataButton()
    func didTapSendEmail(_ sender: UIButton)
    func didTapFacebook()
    func didTapTwitter()
    func didTapInstagram()
}

class HomeTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var sections: [HomeContent] = []
    private weak var tableView: UITableView?

    public weak var delegate: HomeTableHandlerDelegate?

    init(sections: [HomeContent], tableView: UITableView) {
        self.sections = sections
        self.tableView = tableView

        super.init()

        registerCells()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
    }

    // MARK: Public helpers

    public func update(sections: [HomeContent]) {
        self.sections = sections
        tableView?.reloadData()
    }

    // MARK: Private helpers

    private func registerCells() {
        tableView?.register(cell: SummaryCell.self)
        tableView?.register(cell: AboutUsCell.self)
        tableView?.register(cell: SocialCell.self)
        tableView?.register(cell: WebViewCell.self)
        tableView?.register(cell: EmailCell.self)
    }

    // MARK: Data store

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.row]

        switch section {
        case let .summary(text):
            let cell = tableView.dequeue(cell: SummaryCell.self, at: indexPath)
            cell.delegate = self
            cell.setup(with: text)
            return cell
        case let .followUs(socialNetworks):
            let cell = tableView.dequeue(cell: SocialCell.self, at: indexPath)
            cell.setup(with: socialNetworks)
            cell.delegate = self
            return cell
        case let .about(text):
            let cell = tableView.dequeue(cell: AboutUsCell.self, at: indexPath)
            cell.setup(with: text)
            return cell
        case let .webViewPlot(title, url):
            let cell = tableView.dequeue(cell: WebViewCell.self, at: indexPath)
            cell.setup(with: title, url: url)
            return cell
        case .contactUs:
            let cell = tableView.dequeue(cell: EmailCell.self, at: indexPath)
            cell.delegate = self
            return cell
        }
    }

    // MARK: Delegate

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: SummaryCellDelegate

extension HomeTableHandler: SummaryCellDelegate {
    func didTapSeeTeamButton() {
        delegate?.didTapSeeTeamButton()
    }

    func didTapSeeDataButton() {
        delegate?.didTapSeeDataButton()
    }
}

// MARK: EmailCellDelegate

extension HomeTableHandler: EmailCellDelegate {
    func didTapSendEmail(_ sender: UIButton) {
        delegate?.didTapSendEmail(sender)
    }
}

// MARK: SocialCellDelegate

extension HomeTableHandler: SocialCellDelegate {
    func didTapFacebook() {
        delegate?.didTapFacebook()
    }

    func didTapTwitter() {
        delegate?.didTapTwitter()
    }

    func didTapInstagram() {
        delegate?.didTapInstagram()
    }
}
