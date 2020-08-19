//
// Created by Michel Bueno on 18/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol HomeInteractorType {
    var presenter: HomePresenterType? {get set}
    var remoteService: RemoteServiceType? { get set }
    func fetchTweetsFor(username: String)
}

class HomeInteractor: HomeInteractorType {
    var presenter: HomePresenterType?
    var remoteService: RemoteServiceType?

    let bearerToken = "AAAAAAAAAAAAAAAAAAAAACePGwEAAAAAKz0vO7llEv6OT2m6HHujVXuJQPc%3DP7KXorCKshg4c8GeYEd47ywLzilKDxiKMg9ZiT3PcrgMptK6ai"
    let fetchUserBaseUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"

    func fetchTweetsFor(username: String) {
        remoteService?.get(
                url: createFetchUserFinalURL(username: username),
                headers: ["Authorization":"Bearer \(bearerToken)"],
                onSuccess: { data in
                    let tweets = self.parseTweetsData(data: data)
                    self.presenter?.loadTweetsList(with: tweets)
                }, onFailure: {
                    self.presenter?.showError()
                }
        )
    }

    private func createFetchUserFinalURL(username: String) -> URL {
        var urlComponents = URLComponents(string: fetchUserBaseUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "screen_name", value: username)]

        return (urlComponents?.url)!
    }

    private func parseTweetsData(data: Data?) -> [Tweet] {
        let tweets: [Tweet] = []
        if let tweetsArrayObject = try! JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String,AnyObject>] {
            for tweetObject in tweetsArrayObject {
                let tweet = Tweet()
                tweet.text = tweetObject["text"] as? String
                tweet.id = tweetObject["id_str"] as? String
            }
        }
        return tweets
    }
}
