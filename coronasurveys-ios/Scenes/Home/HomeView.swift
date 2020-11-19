//
//  HomeView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import SKCountryPicker
import UIKit

protocol HomeViewDelegate: AnyObject {
    func didTapStartForm()
    func didSelectConutry(code: String)
    func didTapSeeTeamButton()
    func didTapSeeDataButton()
    func didTapSendEmail(_ sender: UIButton)
    func didTapFacebook()
    func didTapTwitter()
    func didTapInstagram()
    func didTapCountry()
}

struct HomeViewVM: Equatable {
    let sections: [HomeContent]?
    let deviceLocale: String?
}

class HomeView: UIView, CleanView {
    typealias VMType = HomeViewVM

    static var emptySkeleton: HomeViewVM = HomeViewVM(sections: [], deviceLocale: nil)
    var viewModel: HomeViewVM = HomeView.emptySkeleton
    var viewState: ViewState = .empty

    weak var delegate: HomeViewDelegate?
    var handler: HomeTableHandler?

    // MARK: UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.white
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
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

    private lazy var startFormButton: LargeButton = {
        let button = LargeButton(style: .filled, showSpinnerWhenTapped: false)
        button.setTitle(L10N.fillSurvey, for: .normal)
        button.addTarget(self, action: #selector(startForm), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var countryPickerFlag: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 3
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
    }()

    private lazy var countryPicker: LargeButton = {
        let button = LargeButton(style: .simple)
        button.setTitleColor(Color.black, for: .normal)
        button.titleLabel?.textAlignment = .left
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(didSelectCountry), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var countryPickerIndications: UILabel = {
        let label = UILabel()
        label.font = .font(.caption)
        label.textColor = Color.midGray
        label.text = L10N.selectYourCountryAndStart
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icon.chevronRight?.tint(with: Color.midGray)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false

        return imageView
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
            tableView,
            bottomView,
            bottomSafeView,
            countryPickerIndications,
            countryPicker,
            countryPickerFlag,
            startFormButton,
            chevronImageView
        ].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomView.topAnchor),

            bottomView.bottomAnchor.constraint(equalTo: bottomSafeView.topAnchor),
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.topAnchor.constraint(equalTo: countryPickerIndications.topAnchor, constant: -2),

            bottomSafeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSafeView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomSafeView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomSafeView.topAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            startFormButton.bottomAnchor.constraint(equalTo: bottomSafeView.topAnchor, constant: -10),
            startFormButton.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            startFormButton.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            startFormButton.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),

            countryPickerFlag.centerYAnchor.constraint(equalTo: countryPicker.centerYAnchor),
            countryPickerFlag.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            countryPickerFlag.widthAnchor.constraint(equalToConstant: 55),
            countryPickerFlag.heightAnchor.constraint(equalToConstant: 32),

            countryPicker.bottomAnchor.constraint(equalTo: startFormButton.topAnchor, constant: -10),
            countryPicker.leadingAnchor.constraint(equalTo: countryPickerFlag.trailingAnchor, constant: 5),
            countryPicker.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            countryPicker.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),

            countryPickerIndications.bottomAnchor.constraint(equalTo: countryPicker.topAnchor, constant: -10),
            countryPickerIndications.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            countryPickerIndications.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            chevronImageView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: countryPicker.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: Clean view

    func display(viewModel: HomeViewVM) {
        self.viewModel = viewModel

        if let sections = viewModel.sections {
            if handler == nil {
                handler = HomeTableHandler(sections: sections, tableView: tableView)
                handler?.delegate = self
            } else {
                handler?.update(sections: sections)
            }
        }

        if let deviceLocale = viewModel.deviceLocale, let country = CountryManager.shared.country(withCode: deviceLocale) {
            countryPicker.setTitle(country.countryName, for: .normal)
            countryPickerFlag.image = country.flag
        } else {
            countryPicker.setTitle(L10N.selectCountry, for: .normal)
            countryPickerFlag.image = nil
        }
    }

    // MARK: Stateful view

    func prepareForLoaded() {}

    func prepareForLoading() {}

    func prepareForError() {}

    func prepareForEmpty() {}

    // MARK: Helpers

    @objc private func startForm() {
        delegate?.didTapStartForm()
    }

    @objc private func didSelectCountry() {
        delegate?.didTapCountry()
    }
}

// MARK: HomeTableHandlerDelegate

extension HomeView: HomeTableHandlerDelegate {
    func didTapFacebook() {
        delegate?.didTapFacebook()
    }

    func didTapTwitter() {
        delegate?.didTapTwitter()
    }

    func didTapInstagram() {
        delegate?.didTapInstagram()
    }

    func didTapSeeTeamButton() {
        delegate?.didTapSeeTeamButton()
    }

    func didTapSeeDataButton() {
        delegate?.didTapSeeDataButton()
    }

    func didTapSendEmail(_ sender: UIButton) {
        delegate?.didTapSendEmail(sender)
    }
}
