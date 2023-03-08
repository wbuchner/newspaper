//
//  ArticleTests.swift
//  NewspaperTests
//
//  Created by Wayne Buchner on 8/3/2023.
//

import XCTest
@testable import Newspaper

final class ArticleTests: XCTestCase {

    func testDecodeArticle() throws {
        // given
        let articles = try? Article.decode(file: "Article.json", bundle: .test)

        // when
        let article = try? XCTUnwrap(articles?.first)

        // then
        XCTAssertNotNil(articles)
        XCTAssertEqual(articles?.count, 1)

        XCTAssertEqual(article?.id, 1520644925)
        XCTAssertEqual(article?.categories?.count, 1)
        XCTAssertEqual(article?.authors?.count, 1)
        XCTAssertEqual(article?.url,
                       "http://www.afr.com/real-estate/residential/renters-turn-first-home-buyers-as-opportunity-opens-up-20230302-p5cp4t")
        XCTAssertEqual(article?.lastModified, 1678073492342)
        XCTAssertEqual(article?.sponsored, false)
        XCTAssertEqual(article?.headline, "Renters turn first home buyers as opportunity opens up")
        XCTAssertEqual(article?.indexHeadline, "Renters turn first home buyers as opportunity opens up")
        XCTAssertEqual(article?.tabletHeadline, "")
        XCTAssertEqual(article?.theAbstract,
                       "With an estimated gap of 12 to 24 months before rising rental yields draw investors back in to parts of the market, some first-time buyers are diving in.")
        XCTAssertEqual(article?.byLine, "Michael Bleby")
        XCTAssertEqual(article?.acceptComments, false)
        XCTAssertEqual(article?.numberOfComments, 0)
        XCTAssertEqual(article?.relatedAssets?.count, 2)
        XCTAssertEqual(article?.relatedImages?.count, 10)
        XCTAssertEqual(article?.companies?.count, 0)
        XCTAssertEqual(article?.legalStatus, .None)
        XCTAssertEqual(article?.sources?.count, 1)
        XCTAssertEqual(article?.assetType, .Article)
        XCTAssertEqual(article?.overrides?.overrideHeadline,
                       "Renters turn first home buyers as opportunity opens up")
        XCTAssertEqual(article?.overrides?.overrideAbstract,
                       "With an estimated gap of 12 to 24 months before rising rental yields draw investors back in to parts of the market, some first-time buyers are diving in.")
        XCTAssertEqual(article?.timeStamp, 1678059851000)
    }
}
