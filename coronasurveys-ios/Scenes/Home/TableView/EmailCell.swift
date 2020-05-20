//
//  EmailCell.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 20/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol EmailCellDelegate: AnyObject {
    func didTapSendEmail()
}

class EmailCell: UITableViewCell, CellIdentifier {
    weak var delegate: EmailCellDelegate?

    // MARK: UI

    private lazy var emailButton: LargeButton = {
        let button = LargeButton(style: .bordered, showSpinnerWhenTapped: false)
        button.setTitle(NSLocalizedString("email_us", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(sendEmailTapped), for: .touchUpInside)
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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    private func setupView() {
        selectionStyle = .none
        [emailButton].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            emailButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            emailButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            emailButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            emailButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }

    // MARK: Helpers

    @objc private func sendEmailTapped() {
        delegate?.didTapSendEmail()
    }
}
