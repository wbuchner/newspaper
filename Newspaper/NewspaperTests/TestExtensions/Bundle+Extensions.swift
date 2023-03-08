//  Bundle+Extensions.swift EnergyAustralia Created by Wayne Buchner on 19/1/2023.

import Foundation

extension Bundle {
    static let test = Bundle(for: BundleToken.self)

    func loadData(filename: String) throws -> Data {
        guard let url = self.url(forResource: filename, withExtension: nil) else {
            throw Error("Unable to find resource named: '\(filename)'")
        }

        return try Data(contentsOf: url)
    }
}

private struct Error: LocalizedError {
    var errorDescription: String

    init(_ message: String) {
        errorDescription = message
    }
}

private final class BundleToken {}
