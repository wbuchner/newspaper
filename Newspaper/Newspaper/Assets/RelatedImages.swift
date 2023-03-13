//
//  RelatedImages.swift
//  Newspaper
//
//  Created by Wayne Buchner on 7/3/2023.
//

import Foundation


/// Related Image Model. Given no swagger documentation supplied, some attributes are implemented as [String] given no data exists
/// Given no swagger exists all attributes other than the id are considered optional.
struct RelatedImage: Decodable, Hashable {
    let id: Int
    let categories: [String]?
    let brands: [String]?
    let authors: [String]?
    let url: String?
    let lastModified: Int?
    let sponsored: Bool?
    let description: String?
    let photographer: String?
    let type: String?
    let width: CGFloat?
    let height: CGFloat?
    let assetType: Article.AssetType?
    let xLarge2x: String?
    let large2x: String?
    let large: String?
    let thumbnail: String?
    let timeStamp: Int?
    var thumbnailURL: URL { URL(string: url ?? "")! }

    init(id: Int, categories: [String]?, brands: [String]?, authors: [String]?, url: String?, lastModified: Int?, sponsored: Bool?, description: String?, photographer: String?, type: String?, width: CGFloat?, height: CGFloat?, assetType: Article.AssetType?, xLarge2x: String?, large2x: String?, large: String?, thumbnail: String?, timeStamp: Int?) {
        self.id = id
        self.categories = categories
        self.brands = brands
        self.authors = authors
        self.url = url
        self.lastModified = lastModified
        self.sponsored = sponsored
        self.description = description
        self.photographer = photographer
        self.type = type
        self.width = width
        self.height = height
        self.assetType = assetType
        self.xLarge2x = xLarge2x
        self.large2x = large2x
        self.large = large
        self.thumbnail = thumbnail
        self.timeStamp = timeStamp
    }
}

/// Related Image requires custom coding keys, a custom init is then required
extension RelatedImage {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        categories = try? values.decode([String].self, forKey: .categories)
        brands = try? values.decode([String].self, forKey: .brands)
        authors = try? values.decode([String].self, forKey: .authors)
        url = try? values.decode(String.self, forKey: .url)
        lastModified = try? values.decode(Int.self, forKey: .lastModified)
        sponsored = try? values.decode(Bool.self, forKey: .sponsored)
        description = try? values.decode(String.self, forKey: .description)
        photographer = try? values.decode(String.self, forKey: .photographer)
        type = try? values.decode(String.self, forKey: .type)
        width = try? values.decode(CGFloat.self, forKey: .width)
        height = try values.decode(CGFloat.self, forKey: .height)
        assetType = try? values.decode(Article.AssetType.self, forKey: .assetType)
        xLarge2x = try? values.decode(String.self, forKey: .xLarge2x)
        large2x = try? values.decode(String.self, forKey: .large2x)
        large = try? values.decode(String.self, forKey: .large)
        thumbnail = try? values.decode(String.self, forKey: .thumbnail)
        timeStamp = try? values.decode(Int.self, forKey: .timeStamp)
    }
}

extension RelatedImage {
    // Unrequired but fun to play with computed values
    var lastModifiedDate: Date? { lastModified?.fromUnixTimeStamp() }
    var timestampDate: Date? { timeStamp?.fromUnixTimeStamp() }
}

extension RelatedImage {
    /// Custom coding keys to support alt characters
    enum CodingKeys: String, CodingKey  {
        case xLarge2x = "xLarge@2x"
        case large2x = "large@2x"
        case id, categories, brands, authors, url, lastModified, sponsored, description
        case photographer, type, width, height, assetType, large, thumbnail, timeStamp
    }
}

extension Sequence where Iterator.Element == RelatedImage {

    /// Returns the smallest image for the Thumbnail based on
    func sortSmallest() -> [Iterator.Element] {
        return self.sorted { (item1, item2) -> Bool in
            guard let width1 = item1.width, let width2 = item2.width,
                  let height1 = item1.height, let height2 = item2.height else {
                return false
            }
            return width1 < width2 &&
            height1 < height2
        }
    }
}
