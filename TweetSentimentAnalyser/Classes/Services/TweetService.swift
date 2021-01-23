//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetServiceType {
    var remoteService: RemoteServiceType? { get set }
    func fetchTweets(forUsername username: String, startingFrom tweetId: String?, onSuccess: @escaping ([Tweet]) -> Void, onFailure: @escaping () -> Void)
}

class TweetService: TweetServiceType {
    var remoteService: RemoteServiceType?
    let authorizationToken = Bundle.main.infoDictionary?["TWITTER_BEARER_TOKEN"] as! String
    let defaultCount = 30

    func fetchTweets(forUsername username: String, startingFrom tweetId: String?, onSuccess: @escaping ([Tweet]) -> Void, onFailure: @escaping () -> Void) {
        remoteService?.get(
                url: createFetchTweetsFinalURL(username, tweetId),
                headers: ["Authorization": "Bearer \(authorizationToken)"],
                onSuccess: { data in
                    var tweets = self.parseTweetsData(data: data)
                    if tweetId != nil {
                        tweets.removeFirst() // API returns last tweet
                    }
                    onSuccess(tweets)
                }, onFailure: {
                    onFailure()
                }
        )
    }

    private func createFetchTweetsFinalURL(_ username: String, _ tweetId: String?) -> URL {
        let fetchTweetsServiceUrl = Bundle.main.infoDictionary?["FETCH_TWEETS_SERVICE_URL"] as! String

        var urlComponents = URLComponents(string: fetchTweetsServiceUrl)
        urlComponents?.queryItems = [
            URLQueryItem(name: "screen_name", value: username),
            URLQueryItem(name: "count", value: "\(defaultCount)")
        ]

        if let max_id = tweetId {
            urlComponents?.queryItems?.append(URLQueryItem(name: "max_id", value: max_id))
        }

        return (urlComponents?.url)!
    }

    private func parseTweetsData(data: Data?) -> [Tweet] {
        var tweets: [Tweet] = []
        if let tweetsArrayObject = try! JSONSerialization.jsonObject(with: data!, options: []) as? [[String: AnyObject]] {
            for tweetObject in tweetsArrayObject {
                let tweet = Tweet()
                tweet.text = tweetObject["text"] as? String
                tweet.id = tweetObject["id_str"] as? String
                tweets.append(tweet)
            }
        }
        return tweets
    }
}
