//
//  RemindersCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol RemindersCellDelegate: AnyObject {
    func didUpdateNotifications(_ uiSwitch: UISwitch)
}

class RemindersCell: UITableViewCell, CellIdentifier {
    weak var delegate: RemindersCellDelegate?

    // MARK: UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10N.reminderEnabled
        label.textColor = Color.black
        label.font = .font(.body1)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.onTintColor = Color.violetBlue
        switcher.addTarget(self, action: #selector(didUpdateNotifications), for: .valueChanged)
        switcher.translatesAutoresizingMaskIntoConstraints = false

        return switcher
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

    public func setup(isActive: Bool) {
        switcher.isOn = isActive
    }

    private func setupView() {
        selectionStyle = .none
        [titleLabel, switcher].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            switcher.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    // MARK: Helpers

    @objc private func didUpdateNotifications(_ uiSwitch: UISwitch) {
        delegate?.didUpdateNotifications(uiSwitch)
    }
}
