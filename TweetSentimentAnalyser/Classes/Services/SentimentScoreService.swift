//
// Created by Michel Bueno on 19/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation

enum SentimentScore {
    case happy
    case neutral
    case sad
}

protocol SentimentScoreServiceType {
    var remoteService: RemoteServiceType? { get set }
    func fetchSentimentScore(forText text: String, onSuccess: @escaping (SentimentScore) -> Void, onFailure: @escaping () -> Void)
}

class SentimentScoreService: SentimentScoreServiceType {
    var remoteService: RemoteServiceType?

    func fetchSentimentScore(forText text: String, onSuccess: @escaping (SentimentScore) -> Void, onFailure: @escaping () -> Void) {
        remoteService?.post(
                url: createFinalURL(),
                parameters: createRequestBodyFor(text),
                onSuccess: { response in
                    if let sentimentScore = self.parseSentimentScore(data: response) {
                        onSuccess(sentimentScore)
                    } else {
                        onFailure()
                    }
                },
                onFailure: {
                    onFailure()
                }
        )
    }

    private func createFinalURL() -> URL {
        let apiKey = Bundle.main.infoDictionary?["GOOGLE_API_KEY"] as! String
        let sentimentScoreServiceUrl = Bundle.main.infoDictionary?["SENTIMENT_SCORE_SERVICE_URL"] as! String
        
        var urlComponents = URLComponents(string: sentimentScoreServiceUrl)
        urlComponents?.queryItems = [URLQueryItem(name: "key", value: apiKey)]

        return (urlComponents?.url)!
    }

    private func parseSentimentScore(data: Data?) -> SentimentScore? {
        var score: SentimentScore? = nil
        if let responseObject = try! JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String,AnyObject> {
            let documentSentiment = responseObject["documentSentiment"]
            let scoreValue = documentSentiment?["score"] as! Double
            switch scoreValue {
            case -1.0 ... -0.25:
                score = SentimentScore.sad
            case -0.25 ... 0.25:
                score = SentimentScore.neutral
            case 0.25 ... 1.0:
                score = SentimentScore.happy
            default:
                score = SentimentScore.neutral
            }
        }
        return score
    }

    private func createRequestBodyFor(_ text: String) -> [String: Any] {
        let requestBody: [String : Any] = [
            "document" : [
                "type":"PLAIN_TEXT",
                "content": text
            ],
            "encodingType": "UTF8"
        ]

        return requestBody
    }

}
