//
//  UIControl+.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

extension UIControl {
    func configureTargets() {
        addTarget(self, action: #selector(buttonTouchUp), for: .touchUpInside)
        addTarget(self, action: #selector(buttonTouchUp), for: .touchDragExit)
        addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
    }

    @objc func buttonTouchDown(sender: UIButton) {
        let transform: CGFloat = 0.95
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator().impactOccurred(intensity: 0.4)
        } else {
            UIImpactFeedbackGenerator().impactOccurred()
        }
        Animate.spring {
            self.transform = CGAffineTransform(scaleX: transform, y: transform)
        }
    }

    @objc func buttonTouchUp(sender: UIButton) {
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator().impactOccurred(intensity: 0.9)
        } else {
            UIImpactFeedbackGenerator().impactOccurred()
        }

        Animate.spring {
            self.transform = .identity
        }
    }

    @objc func buttonDragging(sender: UIButton) {
        let transform: CGFloat = 1.3

        Animate.spring {
            self.transform = CGAffineTransform(scaleX: transform, y: transform)
        }
    }
}
