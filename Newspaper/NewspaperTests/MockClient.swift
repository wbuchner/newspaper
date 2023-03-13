//
//  MockClient.swift
//  NewspaperTests
//
//  Created by Wayne Buchner on 8/3/2023.
//

import Foundation

@testable import Newspaper

class MockNewsClient: NewsClient {
    @MainActor override func fetch(url: URL?) async throws -> Articles? {
        return try? Articles.decodeDict(file: "articles.json", bundle: .test)
    }
}
