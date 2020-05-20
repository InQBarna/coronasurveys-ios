//
//  EndFormViewController.swift
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

protocol EndFormDisplayLogic: AnyObject {
    func displayView(viewModel: EndForm.PrepareView.ViewModel)
}

class EndFormViewController: UIViewController, EndFormDisplayLogic, AutoUpdateContext {
    var interactor: EndFormBusinessLogic?
    var router: (NSObjectProtocol & EndFormRoutingLogic & EndFormDataPassing)?

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

    // MARK: UI

    private lazy var endFormView: EndFormView = {
        EndFormView()
    }()

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
        let interactor = EndFormInteractor()
        let presenter = EndFormPresenter()
        let router = EndFormRouter()
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
        view = endFormView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        prepareView()
    }

    // MARK: Setup methods

    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = Color.black

        let leftBarButtonItem = UIBarButtonItem(image: Icon.xmark, style: .plain, target: self, action: #selector(dismissViewController))
        navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    // MARK: Prepare view

    func prepareView() {
        let request = EndForm.PrepareView.Request()
        interactor?.prepareView(request: request)
    }

    func displayView(viewModel: EndForm.PrepareView.ViewModel) {
        // nameTextField.text = viewModel.name
    }

    // MARK: Helpers

    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
