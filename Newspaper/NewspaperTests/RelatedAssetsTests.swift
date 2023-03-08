//
//  RelatedAssetsTests.swift
//  NewspaperTests
//
//  Created by Wayne Buchner on 8/3/2023.
//

import XCTest
@testable import Newspaper

final class RelatedAssetsTests: XCTestCase {

    func testRelatedAssets() throws {
        // given
        let articles = try? Article.decode(file: "Article.json", bundle: .test)

        // when
        let relatedAssets = try? XCTUnwrap(articles?.first?.relatedAssets)
        let asset = try? XCTUnwrap(relatedAssets?.first)

        // then
        XCTAssertNotNil(relatedAssets)
        XCTAssertEqual(relatedAssets?.count, 2)
        XCTAssertEqual(asset?.id, 1520645342)
        XCTAssertEqual(asset?.categories?.count, 1)
        XCTAssertEqual(asset?.categories?.first?.name, "Residential")
        XCTAssertEqual(asset?.categories?.first?.sectionPath, "/real-estate/residential")
        XCTAssertEqual(asset?.categories?.first?.orderNum, 0)
        XCTAssertEqual(asset?.authors?.count, 1)
        XCTAssertEqual(asset?.url,
                       "http://www.afr.com/real-estate/residential/stock-is-so-tight-right-now-auction-clearances-push-over-70pc-20230304-p5cpge")
        XCTAssertEqual(asset?.lastModified, 1677996968383)
        XCTAssertEqual(asset?.sponsored, false)
        XCTAssertEqual(asset?.assetType, .Article)
        XCTAssertEqual(asset?.headline, "‘Stock is so tight right now’: auction clearances push over 70pc")
        XCTAssertEqual(asset?.timeStamp, 1677978578000)

        let author = try? XCTUnwrap(asset?.authors?.first)
        XCTAssertEqual(author?.name, "Larry Schlesinger")
        XCTAssertEqual(author?.title, "Reporter")
        XCTAssertEqual(author?.email, "larry.schlesinger@afr.com.au")
        XCTAssertEqual(author?.relatedImages?.count, 1)
    }
}
