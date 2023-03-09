//
//  NewsPaperClient.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import Foundation

class NewsClient: ObservableObject {

    @Published var articles = [Article]()

    @MainActor func fetch(url: URL?) async throws -> [Article]? {
        guard let url = url else {
            throw RequestErrors.missingURL
        }
        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw RequestErrors.errorFetchingData }
        return try JSONDecoder().decode([Article].self, from: data)
    }
}
