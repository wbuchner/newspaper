//
//  Article.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import Foundation

struct Articles: Decodable, Identifiable {
    let id: Int
    let categories: [Article.Category]?
    let authors: [Article.Author]?
    let url: String?
    let lastModified: Int?
    let onTime: Int?
    let sponsored: Bool?
    let displayName: String?
    let assets: [Article]?
    let relatedAssets: [RelatedAssets]?
    let relatedImages: [RelatedImage]?
}

struct Article: Decodable, Equatable, Identifiable {
    static func == (lhs: Article, rhs: Article) -> Bool {
        lhs.id != rhs.id
    }

    enum SignPost {
        case EXCLUSIVE
        case OPINION
        case Error
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            let status = try? container.decode(String.self)
            switch status {
            case "EXCLUSIVE": self = .EXCLUSIVE
            case "OPINION": self = .OPINION
            default: self = .Error
            }
        }
    }

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
    let companies: [Company]?
    let legalStatus: LegalStatus?
    let signPost: SignPost?
    let sources: [Source]?
    let assetType: AssetType?
    let overrides: Overrides?
    let timeStamp: Int
    // Computed property for the smallest image for thumbnail,
    // Removes any images where a dimension == 0 to ensure smallest
    // image is retured for the thumbnail. Why did I not just return the URL?
    // not sure but since there are no specific requirements, its just as easy.
    var thumbnail: RelatedImage? {
        relatedImages?.sortSmallest()
            .filter { $0.width != 0 && $0.height != 0 }
            .first
    }

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

    struct Company: Decodable {
        let id: Int?
        let companyCode: String?
        let companyName: String?
        let abbreviatedName: String?
        let exchange: String?
        let companyNumber: String?
    }
}


extension Article.AssetType: Decodable {}
extension Article.LegalStatus: Decodable {}
extension Article.SignPost: Decodable {}
