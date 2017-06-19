//
//  UIViewsExt.swift
//  Ridesharing
//
//  Created by Billy on 6/19/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit

extension UIView {
    func fadeTo(alphaValue: CGFloat, withDuration duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            self.alpha = alphaValue
        }
    }
}
