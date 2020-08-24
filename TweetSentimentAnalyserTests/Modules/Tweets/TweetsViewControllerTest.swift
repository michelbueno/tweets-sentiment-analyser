//
// Created by Michel Bueno on 20/08/20.
// Copyright (c) 2020 Michel Bueno. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import TweetSentimentAnalyser

class TweetsViewControllerTest: QuickSpec {
    override func spec() {
        describe("TweetsViewController") {
            var sut: TweetsViewController!
            var presenterMock: TweetsPresenterMock!
            var tweet: Tweet!
            var tweetsList: [Tweet] = []

            beforeEach {
                presenterMock = TweetsPresenterMock()
                sut = TweetsViewController()
                sut.username = "someUsername"
                sut.presenter = presenterMock
                tweet = Tweet()
                tweet.text = "a tweet"
                tweet.id = "123456"
                tweet.sentimentScore = .neutral
                tweetsList = [tweet]
                sut.tweets.removeAll()
            }

            context("on loadView") {
                it("calls presenter with correct param") {
                    sut.loadView()

                    expect(presenterMock.didCallLoadView).to(beTrue())
                    expect(presenterMock.lastUsernameCalled).to(equal("someUsername"))
                }

                it("sets title with current username") {
                    sut.loadView()

                    expect(sut.navigationItem.title).to(equal("@someUsername"))
                }

                it("sets table view delegate to self") {
                    sut.loadView()

                    expect(sut.tableView.dataSource).toNot(beNil())
                    expect(sut.tableView.dataSource).to(beAKindOf(TweetsViewController.self))
                }
            }

            context("on viewWillAppear") {
                it("shows activity indicator and starts animating") {
                    sut.viewWillAppear(true)

                    expect(sut.activityIndicator.isHidden).to(beFalse())
                    expect(sut.activityIndicator.isAnimating).to(beTrue())
                }
            }

            context("on loadTweets") {
                it("hides activity indicator and stops animating") {
                    sut.loadTweets(tweetsList)

                    expect(sut.activityIndicator.isHidden).to(beTrue())
                    expect(sut.activityIndicator.isAnimating).to(beFalse())
                }

                it("when tweets.count == 0, appends new tweets and reloads the table") {
                    sut.loadTweets(tweetsList)

                    expect(sut.tweets.count).to(equal(tweetsList.count))
                    expect(sut.tweets.first?.text).to(equal(tweetsList.first?.text))
                    expect(sut.tweets.first?.id).to(equal(tweetsList.first?.id))
                }

                it("when tweets.count !=, appends new tweets and reloads the table") {
                    sut.tweets = tweetsList
                    sut.loadTweets([Tweet()])

                    expect(sut.tweets.count).to(equal(2))
                    expect(sut.tweets.first?.text).to(equal(tweetsList.first?.text))
                    expect(sut.tweets.first?.id).to(equal(tweetsList.first?.id))
                    expect(sut.tweets[1].text).to(beNil())
                    expect(sut.tweets[1].id).to(beNil())
                    expect(sut.tweets[1].sentimentScore).to(beNil())
                }
            }

            context("on showError") {
                it("hides activity indicator and stops animating") {
                    sut.showError()

                    expect(sut.activityIndicator.isHidden).to(beTrue())
                    expect(sut.activityIndicator.isAnimating).to(beFalse())
                }

                it("shows error message") {
                    sut.showError()

                    expect(sut.errorLabel.isHidden).to(beFalse())
                    expect(sut.errorLabel.text).to(equal("Failed to fetch Tweets"))
                }
            }

            context("on updateTweet") {
                it("replaces old tweet object on data source object") {
                    sut.loadView()
                    sut.tweets = tweetsList
                    sut.tableView.reloadData()

                    sut.tweets = tweetsList
                    let newTweet = Tweet()
                    newTweet.text = "new tweet"
                    newTweet.id = "123456"

                    sut.updateTweet(newTweet)

                    expect(sut.tweets.first?.text).to(equal("new tweet"))
                }
            }

            context("tableView data source delegate") {
                it("returns 1 for number of sections") {
                    let numberOfSections = sut.numberOfSections(in: sut.tableView)

                    expect(numberOfSections).to(equal(1))
                }

                it("returns number of rows as the same size of tweets array") {
                    sut.tweets = tweetsList
                    let numberOfRows = sut.tableView.numberOfRows(inSection: 0)

                    expect(numberOfRows).to(equal(tweetsList.count))
                }
            }

            context("display cell") {
                beforeEach {
                    sut.loadView()
                    sut.tweets = tweetsList
                    sut.tableView.reloadData()
                }

                it("configures image for sentiment score") {
                    let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TweetsTableViewCell

                    expect(cell.imageView?.image).toNot(beNil())
                }

                it("calls presenter to fetch more tweets when reaches last cell") {
                    let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TweetsTableViewCell

                    expect(presenterMock.didCallFetchMoreTweets).to(beTrue())
                }

                it("calls presenter to get sentiment score when sentimentScore is nil") {
                    sut.tweets.first?.sentimentScore = nil

                    _ = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0))

                    expect(presenterMock.didCallViewWillDisplayCellForTweet).to(beTrue())
                    expect(presenterMock.lastTweetCalledByWillDisplayCell).toNot(beNil())
                }

            }
        }
    }
}