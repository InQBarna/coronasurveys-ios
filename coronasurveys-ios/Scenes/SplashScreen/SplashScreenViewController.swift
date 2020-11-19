//
//  SplashScreenViewController.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright (c) 2020 Inqbarna. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol SplashScreenDisplayLogic: AnyObject {
    func displayView(viewModel: SplashScreen.PrepareView.ViewModel)
}

class SplashScreenViewController: UIViewController, SplashScreenDisplayLogic {
    var interactor: SplashScreenBusinessLogic?
    var router: (NSObjectProtocol & SplashScreenRoutingLogic & SplashScreenDataPassing)?

    // MARK: View

    private lazy var splashScreenView: SplashScreenView = {
        SplashScreenView()
    }()

    // MARK: AutoUpdateContext

    var childrenViewControllers: [UIViewController]? {
        nil
    }

    var context: [Dependency: Any?]? {
        get {
            router?.dataStore?.context
        }
        set {
            var dataStore = router!.dataStore!
            dataStore.context = newValue
        }
    }

    // MARK: Object lifecycle

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = SplashScreenInteractor()
        let presenter = SplashScreenPresenter()
        let router = SplashScreenRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func loadView() {
        super.loadView()
        view = splashScreenView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareView()
    }

    // MARK: Prepare view

    func prepareView() {
        let request = SplashScreen.PrepareView.Request()
        interactor?.prepareView(request: request)
    }

    func displayView(viewModel: SplashScreen.PrepareView.ViewModel) {
        router?.routeToHome()
    }
}
