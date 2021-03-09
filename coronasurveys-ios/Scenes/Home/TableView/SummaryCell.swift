//
//  SummaryCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 19/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol SummaryCellDelegate: AnyObject {
    func didTapSeeTeamButton()
    func didTapSeeDataButton()
}

class SummaryCell: UITableViewCell, CellIdentifier {
    weak var delegate: SummaryCellDelegate?

    // MARK: UI

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = L10N.projectSummaryTitle
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

    private lazy var teamButton: LargeButton = {
        let button = LargeButton(style: .bordered, showSpinnerWhenTapped: false)
        button.setTitle(L10N.team, for: .normal)
        button.addTarget(self, action: #selector(seeTeamButton), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.setTitleColor(Color.smaltBlue, for: .normal)
        button.layer.borderColor = Color.smaltBlue?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var seeOpenSourceDataButton: LargeButton = {
        let button = LargeButton(style: .bordered, showSpinnerWhenTapped: false)
        button.setTitle(L10N.allCollectedData, for: .normal)
        button.addTarget(self, action: #selector(seeDataButton), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.setTitleColor(Color.smaltBlue, for: .normal)
        button.layer.borderColor = Color.smaltBlue?.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
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

    public func setup(with text: String?) {
        selectionStyle = .none
        valueLabel.text = text
    }

    private func setupView() {
        [titleLabel, valueLabel, teamButton, seeOpenSourceDataButton].forEach { contentView.addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),

            teamButton.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 10),
            teamButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            teamButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            teamButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),

            seeOpenSourceDataButton.topAnchor.constraint(equalTo: teamButton.bottomAnchor, constant: 10),
            seeOpenSourceDataButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            seeOpenSourceDataButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            seeOpenSourceDataButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),
            seeOpenSourceDataButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    // MARK: Helpers

    @objc private func seeTeamButton() {
        delegate?.didTapSeeTeamButton()
    }

    @objc private func seeDataButton() {
        delegate?.didTapSeeDataButton()
    }
}
