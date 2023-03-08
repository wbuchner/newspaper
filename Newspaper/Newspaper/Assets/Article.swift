//
//  Article.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import Foundation

struct Article: Decodable {

    enum AssetType {
        case IMAGE
        case Article
        case Error
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let status = try? container.decode(String.self)
            switch status {
            case "IMAGE": self = .IMAGE
            case "ARTICLE": self = .Article
            default: self = .Error
            }
        }
    }

    enum LegalStatus {
        case None
        case Approved
        case Error
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let status = try? container.decode(String.self)
            switch status {
            case "None": self = .None
            case "Approved": self = .Approved
            default: self = .Error
            }
        }
    }

    let id: Int
    let categories: [Category]?
    let authors: [Author]?
    let url: String?
    let lastModified: Int?
    let sponsored: Bool?
    let headline: String?
    let indexHeadline: String?
    let tabletHeadline: String?
    let theAbstract: String?
    let byLine: String?
    let acceptComments: Bool?
    let numberOfComments: Int?
    let relatedAssets: [RelatedAssets]?
    let relatedImages: [RelatedImage]?
    let companies: [String]?
    var legalStatus: LegalStatus?
    let sources: [Source]?
    let assetType: AssetType?
    let overrides: Overrides?
    let timeStamp: Int?

    struct Category: Decodable {
        let name : String?
        let sectionPath: String?
        let orderNum: Int?
    }

    struct Source: Decodable {
        let tagId: String?
    }

    struct Overrides: Decodable {
        let overrideHeadline: String?
        let overrideAbstract: String?
    }
    struct Author: Decodable {
        let name: String?
        let title: String?
        let email: String?
        let relatedAssets: [String]?
        let relatedImages: [RelatedImage]?
        let url: String?
        let lastModified: Int?
        let sponsored: Bool?
        let assetType: AssetType?
        let headline: String?
        let timeStamp: Int?
    }
}


extension Article.AssetType: Decodable {}
extension Article.LegalStatus: Decodable {}
