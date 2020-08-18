//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol HomePresenterType {
    var router: HomeRouterType? { get set }
    func onAnaliseButtonPressed(username: String)
}

class HomePresenter: HomePresenterType {
    var router: HomeRouterType?

    func onAnaliseButtonPressed(username: String) {
        router?.pushToTweetsList(with: username)
    }
}