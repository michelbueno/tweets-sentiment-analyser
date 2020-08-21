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

    func fetchTweetsTextFor(username: String, onSuccess: @escaping ([Tweet]) -> Void, onFailure: @escaping () -> Void) {
        let authorizationToken = Bundle.main.infoDictionary?["TWITTER_BEARER_TOKEN"] as! String
        remoteService?.get(
                url: createFetchTweetsFinalURL(username: username),
                headers: ["Authorization":"Bearer \(authorizationToken)"],
                onSuccess: { data in
                    let tweets = self.parseTweetsData(data: data)
                    onSuccess(tweets)
                }, onFailure: {
                    onFailure()
                }
        )
    }

    private func createFetchTweetsFinalURL(username: String) -> URL {
        let fetchTweetsServiceUrl = Bundle.main.infoDictionary?["FETCH_TWEETS_SERVICE_URL"] as! String
        
        var urlComponents = URLComponents(string: fetchTweetsServiceUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "screen_name", value: username)]

        return (urlComponents?.url)!
    }

    private func parseTweetsData(data: Data?) -> [Tweet] {
        var tweets: [Tweet] = []
        if let tweetsArrayObject = try! JSONSerialization.jsonObject(with: data!, options: []) as? [Dictionary<String,AnyObject>] {
            for tweetObject in tweetsArrayObject {
                let tweetText = tweetObject["text"] as! String
                let tweet = Tweet()
                tweet.text = tweetText
                tweets.append(tweet)
            }
        }
        return tweets
    }
}
