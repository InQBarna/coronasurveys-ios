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
}

struct HomeViewVM: Equatable {}

class HomeView: UIView, CleanView {
    typealias VMType = HomeViewVM

    static var emptySkeleton: HomeViewVM = HomeViewVM()
    var viewModel: HomeViewVM = HomeView.emptySkeleton
    var viewState: ViewState = .empty

    weak var delegate: HomeViewDelegate?

    // MARK: UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = Color.white
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private var bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var bottomSafeView: UIView = {
        let view = UIView()
        view.backgroundColor = Color.white
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private lazy var acceptOrderButton: LargeButton = {
        let button = LargeButton(style: .filled, showSpinnerWhenTapped: false)
        button.setTitle(NSLocalizedString("start_form", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(startForm), for: .touchUpInside)
        button.heightAnchor.constraint(equalToConstant: Layout.buttonHeight).isActive = true

        return button
    }()

    private lazy var countryPicker: CountryPickerView = {
        let picker = CountryPickerView()
        picker.showPhoneCodeInView = false
        picker.showCountryNameInView = true
        picker.showCountryCodeInView = false
        picker.font = .font(.body1)
        return picker
    }()

    private lazy var countryPickerIndications: UILabel = {
        let label = UILabel()
        label.font = .font(.caption)
        label.textColor = Color.midGray
        label.text = NSLocalizedString("select_your_country", comment: "")
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalCentering
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
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
        [tableView, bottomView, bottomSafeView, stackView].forEach { addSubview($0) }
        [countryPickerIndications, countryPicker, acceptOrderButton].forEach { stackView.addArrangedSubview($0) }
    }

    private func setupConstraints() {
        if traitCollection.horizontalSizeClass == .regular {
            tableView.constraintsToReadableLayout()
        } else {
            tableView.constraintsToSuperview()
        }

        NSLayoutConstraint.activate([
            bottomView.bottomAnchor.constraint(equalTo: bottomSafeView.topAnchor),
            bottomView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -10),

            bottomSafeView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSafeView.leftAnchor.constraint(equalTo: leftAnchor),
            bottomSafeView.rightAnchor.constraint(equalTo: rightAnchor),
            bottomSafeView.topAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),

            stackView.bottomAnchor.constraint(equalTo: bottomSafeView.topAnchor, constant: -10),
            stackView.leftAnchor.constraint(equalTo: layoutMarginsGuide.leftAnchor),
            stackView.rightAnchor.constraint(equalTo: layoutMarginsGuide.rightAnchor)
        ])
    }

    // MARK: Clean view

    func display(viewModel: HomeViewVM) {
        self.viewModel = viewModel
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
