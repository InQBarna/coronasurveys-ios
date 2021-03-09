//
//  Animate.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

struct Animate {
    static let damping: CGFloat = 0.7

    static func spring(_ damping: CGFloat = Animate.damping,
                       _ animations: @escaping () -> Void)
    {
        Animate.spring(damping, {
            animations()
        }, completion: nil)
    }

    static func spring(_ damping: CGFloat = Animate.damping,
                       _ animations: @escaping () -> Void,
                       completion: ((Bool) -> Void)? = nil)
    {
        Animate.spring(damping, 0.5, {
            animations()
        }, completion: completion)
    }

    static func spring(_ damping: CGFloat = Animate.damping,
                       _ duration: TimeInterval = 0.5,
                       _ animations: @escaping () -> Void,
                       completion: ((Bool) -> Void)? = nil)
    {
        Animate.spring(damping, duration, 0.0, {
            animations()
        }, completion: completion)
    }

    static func spring(_ damping: CGFloat = Animate.damping,
                       _ duration: TimeInterval = 0.5,
                       _ delay: TimeInterval = 0.0,
                       _ animations: @escaping () -> Void,
                       completion: ((Bool) -> Void)? = nil)
    {
        guard duration != 0.0 else {
            animations()
            return
        }

        UIView.animate(withDuration: duration, delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: 0,
                       options: [.curveEaseInOut,
                                 .allowUserInteraction,
                                 .allowAnimatedContent],
                       animations: { animations() },
                       completion: completion)
    }

    static func shake(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.1 + Float(1 / 3), 1, 1)
        animation.duration = 0.65
        animation.values = [-20.0, 20.0, -10.0, 10.0, 0.0]

        view.layer.add(animation, forKey: "shake")
    }

    static func press(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.1 + Float(1 / 3), 1, 1)
        animation.duration = 0.65
        animation.values = [0.7, 1.2, 0.9, 1.0]

        view.layer.add(animation, forKey: "press")
    }

    static func pressed(view: UIView) {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5, 1.1 + Float(1 / 3), 1, 1)
        animation.duration = 0.65
        animation.values = [1.0, 0.95, 1.05, 1.0]

        view.layer.add(animation, forKey: "press")
    }
}
