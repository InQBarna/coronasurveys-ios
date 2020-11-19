//
//  UIView+Constraints.swift
//  coronasurveys-ios
//
//  Created by Josep Bordes Jové on 18/05/2020.
//  Copyright © 2020 Inqbarna. All rights reserved.
//

import UIKit

extension UIView {
    func constraintsToSuperview(margin: CGFloat = 0) {
        guard let superview = self.superview else {
            assertionFailure("Must not constraint if not having a superview")
            return
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: margin),
            leftAnchor.constraint(equalTo: superview.leftAnchor, constant: margin),
            rightAnchor.constraint(equalTo: superview.rightAnchor, constant: margin),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: margin)
        ])
    }

    func constraintsToSuperviewLayout() {
        guard let superview = self.superview else {
            assertionFailure("Must not constraint if not having a superview")
            return
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.layoutMarginsGuide.topAnchor),
            leftAnchor.constraint(equalTo: superview.layoutMarginsGuide.leftAnchor),
            rightAnchor.constraint(equalTo: superview.layoutMarginsGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.layoutMarginsGuide.bottomAnchor)
        ])
    }

    func constraintsToReadableLayout() {
        guard let superview = self.superview else {
            assertionFailure("Must not constraint if not having a superview")
            return
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leftAnchor.constraint(equalTo: superview.readableContentGuide.leftAnchor),
            rightAnchor.constraint(equalTo: superview.readableContentGuide.rightAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
