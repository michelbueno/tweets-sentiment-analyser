//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol HomePresenterType {
    var router: HomeRouterType? { get set }
    var interactor: HomeInteractorType? { get set }
    var view: HomeViewControllerType? { get set }

    func onAnaliseButtonPressed(username: String)
    func showError()
    func loadTweetsList(with tweets: [Tweet])
}

class HomePresenter: HomePresenterType {
    var router: HomeRouterType?
    var interactor: HomeInteractorType?
    var view: HomeViewControllerType?

    func onAnaliseButtonPressed(username: String) {
        interactor?.fetchTweetsFor(username: username)
    }

    func showError() {
        view?.showErrorMessage()
    }

    func loadTweetsList(with tweets: [Tweet]) {
        router?.showTweetList(with: tweets)
    }
}