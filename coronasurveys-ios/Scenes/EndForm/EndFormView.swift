//
//  EndFormView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct EndFormViewVM: Equatable {}

class EndFormView: UIView, CleanView {
    typealias VMType = EndFormViewVM

    static var emptySkeleton: EndFormViewVM = EndFormViewVM()
    var viewModel: EndFormViewVM = EndFormView.emptySkeleton
    var viewState: ViewState = .empty

    // MARK: UI

    private var thankYouLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.headline4)
        label.textColor = Color.smaltBlue
        label.text = NSLocalizedString("add_reminders", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var thankYouTextLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.body1)
        label.textColor = Color.midGray
        label.text = NSLocalizedString("thank_you_text_reminders", comment: "")
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var bottomSafeView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var registerWeeklyNotificationsFormButton: LargeButton = {
        let button = LargeButton(style: .filled, showSpinnerWhenTapped: false)
        button.setTitle(NSLocalizedString("weekly_reminder", comment: ""), for: .normal)
        //        button.addTarget(self, action: #selector(startForm), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var registerMonthlyNotificationsFormButton: LargeButton = {
        let button = LargeButton(style: .simple)
        button.setTitle(NSLocalizedString("monthly_reminder", comment: ""), for: .normal)
        //        button.addTarget(self, action: #selector(startForm), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var noThanksButton: LargeButton = {
        let button = LargeButton(style: .simple)
        button.setTitle(NSLocalizedString("no_hanks", comment: ""), for: .normal)
        //        button.addTarget(self, action: #selector(startForm), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
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
        [
            bottomView,
            bottomSafeView,
            registerWeeklyNotificationsFormButton,
            thankYouLabel,
            thankYouTextLabel,
            registerMonthlyNotificationsFormButton,
            noThanksButton
        ].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thankYouLabel.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            thankYouLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            thankYouLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            thankYouTextLabel.topAnchor.constraint(equalTo: thankYouLabel.bottomAnchor, constant: 20),
            thankYouTextLabel.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            thankYouTextLabel.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            bottomView.bottomAnchor.constraint(equalTo: bottomSafeView.topAnchor),
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.topAnchor.constraint(equalTo: noThanksButton.topAnchor, constant: -2),

            bottomSafeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSafeView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomSafeView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomSafeView.topAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            registerWeeklyNotificationsFormButton.bottomAnchor.constraint(equalTo: bottomSafeView.topAnchor, constant: -10),
            registerWeeklyNotificationsFormButton.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            registerWeeklyNotificationsFormButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            registerWeeklyNotificationsFormButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),

            registerMonthlyNotificationsFormButton.bottomAnchor.constraint(equalTo: registerWeeklyNotificationsFormButton.topAnchor, constant: -10),
            registerMonthlyNotificationsFormButton.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            registerMonthlyNotificationsFormButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            registerMonthlyNotificationsFormButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),

            noThanksButton.bottomAnchor.constraint(equalTo: registerMonthlyNotificationsFormButton.topAnchor, constant: -10),
            noThanksButton.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            noThanksButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            noThanksButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight)
        ])
    }

    // MARK: Clean view

    func display(viewModel: EndFormViewVM) {
        self.viewModel = viewModel
    }

    // MARK: Stateful view

    func prepareForLoaded() {}

    func prepareForLoading() {}

    func prepareForError() {}

    func prepareForEmpty() {}
}
