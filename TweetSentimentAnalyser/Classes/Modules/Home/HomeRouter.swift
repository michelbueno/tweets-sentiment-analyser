//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol HomeRouterType {
    func createModule() -> UINavigationController
}

class HomeRouter: HomeRouterType {
    func createModule() -> UINavigationController {
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }

}