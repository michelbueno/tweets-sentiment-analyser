//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol HomePresenterType {
    var router: HomeRouterType? { get set }
    var view: HomeViewControllerType? { get set }

    func onAnaliseButtonPressed(username: String)
}

class HomePresenter: HomePresenterType {
    var router: HomeRouterType?
    var view: HomeViewControllerType?

    func onAnaliseButtonPressed(username: String) {
        router?.navigateToTweetsList(with: username)
    }
}