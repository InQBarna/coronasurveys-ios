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
        label.text = NSLocalizedString("summary_title", comment: "")
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
        let button = LargeButton(style: .simple, showSpinnerWhenTapped: false)
        button.setTitle(NSLocalizedString("team", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(seeTeamButton), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.setTitleColor(Color.smaltBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var seeOpenSourceDataButton: LargeButton = {
        let button = LargeButton(style: .simple, showSpinnerWhenTapped: false)
        button.setTitle(NSLocalizedString("see_open_source_data", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(seeDataButton), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.setTitleColor(Color.smaltBlue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
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
        selectionStyle = .none
        valueLabel.text = text
    }

    private func setupView() {
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

    // MARK: Helpers

    @objc private func seeTeamButton() {
        delegate?.didTapSeeDataButton()
    }

    @objc private func seeDataButton() {
        delegate?.didTapSeeTeamButton()
    }
}
