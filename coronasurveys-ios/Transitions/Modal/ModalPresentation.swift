//
//  ModalPresentation.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

protocol ModalViewController {
    var containerViewGetter: UIView { get }
    var backgroundViewGetter: UIView { get }
}

class ModalPresentation<R: UIViewController & ModalViewController>: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) as? ModalViewController & UIViewController else { return }

        toViewController.containerViewGetter.transform = CGAffineTransform(translationX: 0, y: 250)
        toViewController.containerViewGetter.alpha = 0

        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        toViewController.view.isHidden = false

        let duration = transitionDuration(using: transitionContext)

        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: 6,
            initialSpringVelocity: 9,
            options: [.beginFromCurrentState, .allowUserInteraction],
            animations: {
                toViewController.containerViewGetter.transform = CGAffineTransform(translationX: 0, y: 0)
                toViewController.containerViewGetter.alpha = 1
            }
        ) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
