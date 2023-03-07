//
//  Int+Extension.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import Foundation

extension Int {
    func  fromUnixTimeStamp() -> Date? {
        let date = Date(timeIntervalSince1970: TimeInterval(self) / 1000)
        return date
    }
}
