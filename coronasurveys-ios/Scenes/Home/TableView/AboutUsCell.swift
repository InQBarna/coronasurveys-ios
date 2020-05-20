//
//  AboutUs.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

class AboutUsCell: UITableViewCell, CellIdentifier {
    // MARK: UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("about_us_title", comment: "")
        label.textColor = Color.smaltBlue
        label.font = .font(.headline6)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.body1)
        label.textColor = Color.midGray
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
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

    public func setup(with text: String?) {
        valueLabel.text = text
    }

    private func setupView() {
        selectionStyle = .none
        [titleLabel, valueLabel].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}
