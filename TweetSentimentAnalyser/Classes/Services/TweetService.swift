//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

protocol TweetServiceType {
    var remoteService: RemoteServiceType? { get set }
    func fetchTweetsTextFor(username: String, onSuccess: @escaping ([Tweet]) -> Void, onFailure: @escaping () -> Void)
}

class TweetService: TweetServiceType {
    var remoteService: RemoteServiceType?

    let bearerToken = "AAAAAAAAAAAAAAAAAAAAACePGwEAAAAAKz0vO7llEv6OT2m6HHujVXuJQPc%3DP7KXorCKshg4c8GeYEd47ywLzilKDxiKMg9ZiT3PcrgMptK6ai"
    let fetchUserBaseUrl = "https://api.twitter.com/1.1/statuses/user_timeline.json"

    func fetchTweetsTextFor(username: String, onSuccess: @escaping ([Tweet]) -> Void, onFailure: @escaping () -> Void) {
        remoteService?.get(
                url: createFetchUserFinalURL(username: username),
                headers: ["Authorization":"Bearer \(bearerToken)"],
                onSuccess: { data in
                    let tweets = self.parseTweetsData(data: data)
                    onSuccess(tweets)
                }, onFailure: {
                    onFailure()
                }
        )
    }

    private func createFetchUserFinalURL(username: String) -> URL {
        var urlComponents = URLComponents(string: fetchUserBaseUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "screen_name", value: username)]

        return (urlComponents?.url)!
    }

    private func parseTweetsData(data: Data?) -> [Tweet] {
        var tweets: [Tweet] = []
        if let tweetsArrayObject = try! JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String,AnyObject>] {
            for tweetObject in tweetsArrayObject {
                let tweetText = tweetObject["text"] as! String
                let tweetId = tweetObject["id_str"] as! String
                let tweet = Tweet()
                tweet.text = tweetText
                tweet.id = tweetId
                tweets.append(tweet)
            }
        }
        return tweets
    }
}