//  Decodable+Extensions.swift EnergyAustralia Created by Wayne Buchner on 19/1/2023.

import Foundation
@testable import Newspaper

extension Decodable {
    static func decode(file: String, bundle: Bundle = .test) throws -> [RelatedImage]? {
        guard let url = Bundle.test.url(forResource: file, withExtension: nil) else {
            throw FileNotFound()
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([RelatedImage].self, from: data)
    }

    static func decode(json: String) throws -> [RelatedImage]? {
        return try JSONDecoder().decode([RelatedImage].self, from: json.data(using: .utf8)!)
    }
}

private struct FileNotFound: Error { }
