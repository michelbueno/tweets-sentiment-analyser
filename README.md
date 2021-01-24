# Tweet Sentiment Analyser [![Build Status](https://app.bitrise.io/app/57ce24b4f8b238dc/status.svg?token=IU6Gz621DpEFLrqsPOnrqw)](https://app.bitrise.io/app/57ce24b4f8b238dc)

An iOS App that lists the tweets of a given username using Twitter API and shows a sentiment score (sad, neutral, happy) for each tweet. It relies on **Google Natural Language API** to make this sentiment analysis possible.

## Teck Stack
- XCode 12.3
- [Cocoapods](https://github.com/CocoaPods/CocoaPods) 1.10.0 

## Dependencies
- [Quick](https://github.com/Quick/Quick)
- [Nimble](https://github.com/Quick/Nimble)
- [Alamofire](https://github.com/Alamofire/Alamofire)
- [SnapKit](https://github.com/SnapKit/SnapKit)
- [OHHTTPStubs/Swift](https://github.com/AliSoftware/OHHTTPStubs)

## Architecture
This app was built based on a clean architecture model called **VIPER.** Basically, each of the letters in VIPER stansd for a component of the architecture: **View, Interactor, Presenter, Entity and Router:**

- The **View** is the user interface, generally corresponding to UIKit components.
- The **Interactor** is a class that mediates between the presenter and the data. Gerenally, this is a UIKit-independent component that handles business logic. For example, in this app, it uses some Services to communicate with Twitter and Google API's to fetch the info we want to display.
- The **Presenter** is the coordintor of the architecture, directing data between the view and interactor, taking user actions and calling Router to move the user between screens.
- An **Entity** represents application data.
- The **Router** handles navigation between screens. In this app, it is also responsible to create the module itself and receives another name: **Wireframe.**

---
## Before you start
You must setup few credentials to be able to use this project. First of all, you need to apply for a developer account on these services:
- [Twitter API](https://developer.twitter.com/en/apply-for-access)
- [Google Natural Language API](https://cloud.google.com/natural-language/)

## Authentication
This project depends on a bearer token to authenticate on Twitter API. To generate one, please follow [this guide](https://developer.twitter.com/en/docs/authentication/oauth-2-0/bearer-tokens).

Also, you'll need an API key to access Google Natural Language service. To get a new one, please follow [this guide](https://cloud.google.com/natural-language/docs/setup)

---
## Running the project
1. Install dependencies with Cocoapods
```shell
pod install
```
2. Open the workspace
```shell
open TweetSentimentAnalyser.xcworkspace
```
3. Select *TweetSentimentAnalyser* project in the workspace and configure the following credentials under **Build Settings>User-defined:**
```shell
TWITTER_BEARER_TOKEN
GOOGLE_API_KEY
```
4. Hit play and have fun :)
