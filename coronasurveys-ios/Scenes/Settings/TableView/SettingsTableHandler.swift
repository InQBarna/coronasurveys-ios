//
//  SettingsTableHandler.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol SettingsTableHandlerDelegate: AnyObject {}

class SettingsTableHandler: NSObject, UITableViewDelegate, UITableViewDataSource {
    private var sections: [SettingsContent] = []
    private weak var tableView: UITableView?

    public weak var delegate: SettingsTableHandlerDelegate?

    init(sections: [SettingsContent], tableView: UITableView) {
        self.sections = sections
        self.tableView = tableView

        super.init()

        registerCells()
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.reloadData()
    }

    // MARK: Public helpers

    public func update(sections: [SettingsContent]) {
        self.sections = sections
        tableView?.reloadData()
    }

    // MARK: Private helpers

    private func registerCells() {
        tableView?.register(cell: RemindersCell.self)
    }

    // MARK: Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = sections[indexPath.row]

        switch section {
        case let .reminders(active):
            let cell = tableView.dequeue(cell: RemindersCell.self, at: indexPath)
            cell.setup(isActive: active)
            return cell
        }
    }
}
