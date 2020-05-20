//
//  ModalDismissal.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

class ModalDismissal<R: UIViewController & ModalViewController>: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        0.7
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) as? ModalViewController & UIViewController else { return }

        let duration = transitionDuration(using: transitionContext)
        let backgroundTransitionDuration = 0.3

        UIView.animate(
            withDuration: duration - backgroundTransitionDuration,
            delay: 0,
            usingSpringWithDamping: 6,
            initialSpringVelocity: 9,
            options: [.beginFromCurrentState],
            animations: {
                fromViewController.containerViewGetter.transform = CGAffineTransform(translationX: 0, y: 250)
                fromViewController.containerViewGetter.alpha = 0
            }
        ) { _ in
            UIView.animate(withDuration: backgroundTransitionDuration, animations: {
                fromViewController.backgroundViewGetter.alpha = 0
            }) { _ in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
    }
}
