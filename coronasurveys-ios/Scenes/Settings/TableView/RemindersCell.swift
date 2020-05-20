//
//  RemindersCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

class RemindersCell: UITableViewCell, CellIdentifier {
    // MARK: UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("reminders_on", comment: "")
        label.textColor = Color.black
        label.font = .font(.body1)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = Color.violetBlue
        switcher.translatesAutoresizingMaskIntoConstraints = false

        return switcher
    }()

    // MARK: Object lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    public func setup(isActive: Bool) {}

    private func setupView() {
        selectionStyle = .none
        [titleLabel, switcher].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            switcher.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            switcher.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
