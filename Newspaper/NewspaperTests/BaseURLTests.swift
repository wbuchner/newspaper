//
//  BaseURLTests.swift
//  NewspaperTests
//
//  Created by Wayne Buchner on 7/3/2023.
//

import XCTest
@testable import Newspaper

final class BaseURLTests: XCTestCase {

    func testBaseURL() {

        XCTAssertNotNil(Configuration().baseURL)

        XCTAssertNotNil(Configuration().path)

        XCTAssertEqual(
            Configuration().baseURL?.absoluteString,
            "https://bruce-v2-mob.fairfaxmedia.com.au")

        XCTAssertEqual(
            Configuration().path?.absoluteString,
            "https://bruce-v2-mob.fairfaxmedia.com.au/1/coding_test/13ZZQX/full")
    }

}
