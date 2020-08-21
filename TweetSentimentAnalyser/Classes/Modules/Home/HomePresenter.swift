//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol HomePresenterType {
    var wireframe: HomeWireframeType? { get set }
    var view: HomeViewControllerType? { get set }

    func onAnaliseButtonPressed(username: String)
}

class HomePresenter: HomePresenterType {
    var wireframe: HomeWireframeType?
    var view: HomeViewControllerType?

    func onAnaliseButtonPressed(username: String) {
        wireframe?.navigateToTweetsList(with: username)
    }
}