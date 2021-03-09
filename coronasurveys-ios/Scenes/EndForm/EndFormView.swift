//
//  EndFormView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol EndFormViewDelegate: AnyObject {
    func dailyNotifications()
    func weeklyNotifications()
    func noNotifications()
}

struct EndFormViewVM: Equatable {}

class EndFormView: UIStackView, CleanView {
    typealias VMType = EndFormViewVM

    static var emptySkeleton = EndFormViewVM()
    var viewModel: EndFormViewVM = EndFormView.emptySkeleton
    var viewState: ViewState = .empty

    weak var delegate: EndFormViewDelegate?

    // MARK: UI

    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 5
        view.backgroundColor = Color.white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var thankYouLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.headline4)
        label.textColor = Color.smaltBlue
        label.text = L10N.addReminderTitle
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private var thankYouTextLabel: UILabel = {
        let label = UILabel()
        label.font = .font(.body1)
        label.textColor = Color.midGray
        label.text = L10N.addReminderText
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var registerDailyNotificationsFormButton: LargeButton = {
        let button = LargeButton(style: .filled, showSpinnerWhenTapped: false)
        button.setTitle(L10N.dailyReminder, for: .normal)
        button.addTarget(self, action: #selector(dailyNotifications), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var registerWeeklyNotificationsFormButton: LargeButton = {
        let button = LargeButton(style: .simple)
        button.setTitle(L10N.weeklyReminder, for: .normal)
        button.addTarget(self, action: #selector(weeklyNotifications), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var noThanksButton: LargeButton = {
        let button = LargeButton(style: .simple)
        button.setTitle(L10N.noThanks, for: .normal)
        button.addTarget(self, action: #selector(noNotifications), for: .touchUpInside)
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

    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup methods

    private func setupView() {
        axis = .vertical
        spacing = 5
        alignment = .fill
        distribution = .fill
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = Color.white

        addSubview(backgroundView)

        let separationView = UIView()
        separationView.heightAnchor.constraint(equalToConstant: 80).isActive = true

        [
            thankYouLabel,
            thankYouTextLabel,
            separationView,
            noThanksButton,
            registerWeeklyNotificationsFormButton,
            registerDailyNotificationsFormButton
        ].forEach { addArrangedSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor, constant: -15),
            backgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: -15),
            backgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 15),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 15)
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

    // MARK: Helpers

    @objc private func dailyNotifications() {
        delegate?.dailyNotifications()
    }

    @objc private func weeklyNotifications() {
        delegate?.weeklyNotifications()
    }

    @objc private func noNotifications() {
        delegate?.noNotifications()
    }
}
