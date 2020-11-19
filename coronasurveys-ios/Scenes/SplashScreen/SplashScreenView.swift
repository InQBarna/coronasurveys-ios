//
//  SplashScreenView.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct SplashScreenViewVM: Equatable {}

class SplashScreenView: UIView, CleanView {
    typealias VMType = SplashScreenViewVM

    static var emptySkeleton: SplashScreenViewVM = SplashScreenViewVM()
    var viewModel: SplashScreenViewVM = SplashScreenView.emptySkeleton
    var viewState: ViewState = .empty

    // MARK: UI

    private lazy var splashImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Asset.splashScreen
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
        [splashImageView].forEach { addSubview($0) }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: topAnchor),
            splashImageView.leftAnchor.constraint(equalTo: leftAnchor),
            splashImageView.rightAnchor.constraint(equalTo: rightAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    // MARK: Clean view

    func display(viewModel: SplashScreenViewVM) {
        self.viewModel = viewModel
    }

    // MARK: Stateful view

    func prepareForLoaded() {}

    func prepareForLoading() {}

    func prepareForError() {}

    func prepareForEmpty() {}
}
