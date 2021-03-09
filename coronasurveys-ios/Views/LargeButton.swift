//
//  LargeButton.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct LargeButtonVM: Equatable {
    let style: LargeButtonStyle
    let title: String
    let showSpinnerWhenTapped: Bool

    init(style: LargeButtonStyle, title: String, showSpinnerWhenTapped: Bool = false) {
        self.style = style
        self.title = title
        self.showSpinnerWhenTapped = showSpinnerWhenTapped
    }
}

enum LargeButtonStyle {
    case simple
    case filled
    case bordered
}

class LargeButton: UIButton, CleanView {
    let style: LargeButtonStyle
    var showSpinnerWhenTapped: Bool

    // MARK: Clean view

    typealias VMType = LargeButtonVM

    var viewModel: LargeButtonVM = LargeButton.emptySkeleton
    var viewState: ViewState = .loading

    static var emptySkeleton: LargeButtonVM {
        LargeButtonVM(style: .filled, title: "Button")
    }

    // MARK: UI

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .white)
        view.hidesWhenStopped = true
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    // MARK: Object lifecycle

    init(style: LargeButtonStyle = .simple, showSpinnerWhenTapped: Bool = false) {
        self.style = style
        self.showSpinnerWhenTapped = showSpinnerWhenTapped
        super.init(frame: .zero)

        setupView()
        setup(with: style)
        setupConstraints()
        configureTargets()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods

    public func setTitle(_ title: String, action: String) {
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.black!,
            .font: UIFont.font(.button)
        ]

        let actionAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: Color.violetBlue!,
            .font: UIFont.font(.button)
        ]

        let result = NSMutableAttributedString()
        let title = NSAttributedString(string: title, attributes: normalAttributes)
        result.append(title)

        result.append(NSAttributedString(string: " ", attributes: [:]))

        let action = NSAttributedString(string: action, attributes: actionAttributes)
        result.append(action)

        setAttributedTitle(result, for: .normal)
    }

    // MARK: Setup methods

    private func setupView() {
        addTarget(self, action: #selector(setupLoadSpinnerIfNeeded), for: .touchUpInside)
        addSubview(activityIndicator)
        layer.cornerRadius = 6
        titleLabel?.font = .font(.button)
        titleLabel?.adjustsFontSizeToFitWidth = true
        clipsToBounds = true
    }

    private func setup(with style: LargeButtonStyle) {
        switch style {
        case .bordered:
            backgroundColor = Color.white
            layer.borderWidth = 1
            layer.borderColor = Color.violetBlue?.cgColor
            setTitleColor(Color.violetBlue, for: .normal)
        case .filled:
            backgroundColor = Color.violetBlue
            setTitleColor(Color.white, for: .normal)
        case .simple:
            backgroundColor = .clear
            setTitleColor(Color.violetBlue, for: .normal)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
        ])
    }

    @objc private func setupLoadSpinnerIfNeeded() {
        if showSpinnerWhenTapped {
            activityIndicator.startAnimating()
        }
    }

    // MARK: Clean view methods

    func display(viewModel: LargeButtonVM) {
        self.viewModel = viewModel

        setup(with: viewModel.style)
        setTitle(viewModel.title, for: .normal)
        showSpinnerWhenTapped = viewModel.showSpinnerWhenTapped
    }

    func prepareForLoaded() {
        isUserInteractionEnabled = true
        alpha = 1
        activityIndicator.stopAnimating()
    }

    func prepareForLoading() {
        isUserInteractionEnabled = false
        alpha = 0.5
    }

    func prepareForError() {
        prepareForLoaded()
    }

    func prepareForEmpty() {}
}
