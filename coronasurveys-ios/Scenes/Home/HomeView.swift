//
//  HomeView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import CountryPickerView
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
}

struct HomeViewVM: Equatable {
    let sections: [HomeContent]
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
        button.setTitle(NSLocalizedString("start_form", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(startForm), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()

    private lazy var countryPicker: CountryPickerView = {
        let picker = CountryPickerView()
        picker.showPhoneCodeInView = false
        picker.showCountryNameInView = true
        picker.showCountryCodeInView = false
        picker.font = .font(.button)
        picker.delegate = self
        picker.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true
        picker.translatesAutoresizingMaskIntoConstraints = false

        return picker
    }()

    private lazy var countryPickerIndications: UILabel = {
        let label = UILabel()
        label.font = .font(.caption)
        label.textColor = Color.midGray
        label.text = NSLocalizedString("select_your_country_and_start", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Icon.chevronRight?.tint(with: Color.violetBlue)
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
        [tableView, bottomView, bottomSafeView, countryPickerIndications, countryPicker, startFormButton, chevronImageView].forEach { addSubview($0) }
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

            countryPicker.bottomAnchor.constraint(equalTo: startFormButton.topAnchor, constant: -10),
            countryPicker.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            countryPicker.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor),
            countryPicker.heightAnchor.constraint(equalToConstant: Layout.buttonHeight),

            countryPickerIndications.bottomAnchor.constraint(equalTo: countryPicker.topAnchor, constant: -10),
            countryPickerIndications.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            countryPickerIndications.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),

            chevronImageView.trailingAnchor.constraint(equalTo: countryPicker.trailingAnchor),
            chevronImageView.centerYAnchor.constraint(equalTo: countryPicker.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 20),
            chevronImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }

    // MARK: Clean view

    func display(viewModel: HomeViewVM) {
        self.viewModel = viewModel

        if handler == nil {
            handler = HomeTableHandler(sections: viewModel.sections, tableView: tableView)
            handler?.delegate = self
        } else {
            handler?.update(sections: viewModel.sections)
        }

        if let deviceLocale = viewModel.deviceLocale {
            countryPicker.setCountryByCode(deviceLocale)
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
}

// MARK: CountryPickerViewDelegate

extension HomeView: CountryPickerViewDelegate {
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country) {
        delegate?.didSelectConutry(code: country.code)
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
