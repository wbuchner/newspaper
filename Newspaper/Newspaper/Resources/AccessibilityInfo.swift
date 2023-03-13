//
//  AccessibilityInfo.swift
//  Newspaper
//
//  Created by Wayne Buchner on 13/3/2023.
//

import Foundation
struct AccessibilityInfo: Equatable {
    let id = UUID()
    var label: String
    var value: String?
    var hint: String?

    init(label: String,
         value: String? = nil,
         hint: String? = nil) {
        self.label = label
        self.value = value
        self.hint = hint
  }
}

