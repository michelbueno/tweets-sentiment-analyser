//
// Created by Michel Bueno on 17/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import UIKit

protocol TweetsRouterType {
    func createModule(with tweets: [Tweet]) -> UIViewController
}

class TweetsRouter: TweetsRouterType {
    func createModule(with tweets: [Tweet]) -> UIViewController {
        let viewController = TweetsViewController()
        viewController.tweets = tweets
        return viewController
    }
}