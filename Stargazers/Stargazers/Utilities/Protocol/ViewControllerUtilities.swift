//
//  ViewControllerUtilities.swift
//  Stargazers
//
//  Created by Alessio Quattrocchi on 20/11/22.
//

import UIKit

enum Storyboard: String {
    case main = "Stargazers"
}

protocol ViewControllerUtilities where Self: UIViewController {
    static func initialize(on storyboard: Storyboard) -> Self
}

