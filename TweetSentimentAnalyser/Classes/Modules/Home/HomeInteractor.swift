//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol HomeInteractorType {
    var presenter: HomePresenterType? {get set}
    var tweetService: TweetServiceType? { get set }
    func fetchTweetsFor(username: String)
}

class HomeInteractor: HomeInteractorType {
    var presenter: HomePresenterType?
    var tweetService: TweetServiceType?
    var sentimentService: SentimentScoreServiceType?

    func fetchTweetsFor(username: String) {
        tweetService?.fetchTweetsTextFor(username: username, onSuccess: { tweetsTextList in
            self.presenter?.loadTweetsList(with: tweetsTextList)
        }, onFailure: {
            self.presenter?.showError()
        })
    }
}
