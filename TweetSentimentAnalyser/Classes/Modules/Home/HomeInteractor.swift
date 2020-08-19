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

    func fetchTweetsFor(username: String) {
        tweetService?.fetchTweetsTextFor(username: username, onSuccess: { tweetsTextList in
            let tweets = self.parseTweetsList(tweetsTextList)
            self.presenter?.loadTweetsList(with: tweets)
        }, onFailure: {
            self.presenter?.showError()
        })
    }

    private func parseTweetsList(_ list: [String]) -> [Tweet]{
        var tweets: [Tweet] = []
        for text in list {
            debugPrint(text)
            let tweet = Tweet()
            tweet.text = text
        }
        return tweets
    }


}
