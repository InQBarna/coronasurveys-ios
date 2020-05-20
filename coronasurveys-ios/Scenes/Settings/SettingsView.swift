//
//  SettingsView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct SettingsViewVM: Equatable {
    let sections: [SettingsContent]
}

class SettingsView: UIView, CleanView {
    typealias VMType = SettingsViewVM

    static var emptySkeleton: SettingsViewVM = SettingsViewVM(sections: [])
    var viewModel: SettingsViewVM = SettingsView.emptySkeleton
    var viewState: ViewState = .empty

    var handler: SettingsTableHandler?

    // MARK: UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.white
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
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
        [tableView].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            tableView.constraintsToReadableLayout()
        } else {
            tableView.constraintsToSuperview()
        }
    }

    // MARK: Clean view

    func display(viewModel: SettingsViewVM) {
        self.viewModel = viewModel

        if handler == nil {
            handler = SettingsTableHandler(sections: viewModel.sections, tableView: tableView)
        } else {
            handler?.update(sections: viewModel.sections)
        }
    }

    // MARK: Stateful view

    func prepareForLoaded() {}

    func prepareForLoading() {}

    func prepareForError() {}

    func prepareForEmpty() {}
}
