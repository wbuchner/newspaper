//  Decodable+Extensions.swift EnergyAustralia Created by Wayne Buchner on 19/1/2023.

import Foundation
@testable import Newspaper

extension Decodable {
    static func decode(file: String, bundle: Bundle = .test) throws -> [Self]? {
        guard let url = Bundle.test.url(forResource: file, withExtension: nil) else {
            throw FileNotFound()
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Self].self, from: data)
    }

    static func decode(json: String) throws -> [Self]? {
        return try JSONDecoder().decode([Self].self, from: json.data(using: .utf8)!)
    }

    static func decodeDict(file: String, bundle: Bundle = .test) throws -> Self? {
        guard let url = Bundle.test.url(forResource: file, withExtension: nil) else {
            throw FileNotFound()
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Self.self, from: data)
    }

    static func decode(json: String) throws -> Self? {
        return try JSONDecoder().decode(Self.self, from: json.data(using: .utf8)!)
    }
}

private struct FileNotFound: Error { }
