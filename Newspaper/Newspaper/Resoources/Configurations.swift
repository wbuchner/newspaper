//
//  Configurations.swift
//  Newspaper - Base URL configuration
//
//  Created by Wayne Buchner on 7/3/2023.
//


import Foundation

struct Configuration {
    var baseURL: URL? { URL(string: "https://bruce-v2-mob.fairfaxmedia.com.au") }
    var path: URL? { baseURL?.appendingPathComponent("/1/coding_test/13ZZQX/full") }
}
