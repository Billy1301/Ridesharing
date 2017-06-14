//
//  CenterVCDelegate.swift
//  Ridesharing
//
//  Created by Billy on 6/14/17.
//  Copyright © 2017 Billy. All rights reserved.
//

import UIKit

protocol CenterVCDelegate {
    func toggleLeftPanel()
    func addLeftPanelViewController()
    func animateLeftPanel(shouldExpand: Bool)
}
