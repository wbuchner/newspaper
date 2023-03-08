//
//  RelatedImagesTests.swift
//  NewspaperTests
//
//  Created by Wayne Buchner on 7/3/2023.
//

import XCTest
@testable import Newspaper

final class RelatedImagesTests: XCTestCase {
    func testDecodeRelatedImage() throws {
        // given
        let relatedImages = try? RelatedImage.decode(file: "RelatedImage.json", bundle: .test)

        // when
        let relatedImage = try? XCTUnwrap(relatedImages?.first)

        // then
        XCTAssertNotNil(relatedImages)
        XCTAssertEqual(relatedImages?.count, 1)

        XCTAssertEqual(relatedImage?.id, 1031763889)
        XCTAssertEqual(relatedImage?.categories?.count, 0)
        XCTAssertEqual(relatedImage?.brands?.count, 0)
        XCTAssertEqual(relatedImage?.authors?.count, 0)
        XCTAssertEqual(relatedImage?.url,
                       "https://www.fairfaxstatic.com.au/content/dam/images/h/2/a/a/4/1/image.related.articleLeadwide.1500x844.p5cp4t.13zzqx.png/1678096659717.jpg")
        XCTAssertEqual(relatedImage?.lastModified, 1678057442936)
        XCTAssertEqual(relatedImage?.sponsored, false)
        XCTAssertEqual(relatedImage?.description, "The 2-bedroom, 2-bathroom apartment in the Lucent building at 1802/225 Pacific Highway in North Sydney sold by private treaty for $1.35 million.")
        XCTAssertEqual(relatedImage?.photographer, "")
        XCTAssertEqual(relatedImage?.type, "articleLeadWide")
        XCTAssertEqual(relatedImage?.width, 1500)
        XCTAssertEqual(relatedImage?.height, 844)
        XCTAssertEqual(relatedImage?.assetType, .IMAGE)
        XCTAssertEqual(relatedImage?.xLarge2x, "")
        XCTAssertEqual(relatedImage?.large2x, "")
        XCTAssertEqual(relatedImage?.large, "")
        XCTAssertEqual(relatedImage?.thumbnail, "")
        XCTAssertEqual(relatedImage?.timeStamp, 1678057442936)
    }

    func testRelatedImageModel() {
        // when
        let relatedImage = RelatedImage.make()

        // then
        XCTAssertNotNil(relatedImage)
    }
}

/// Mock data for ease of testing
extension RelatedImage {
    static func make(id: Int = 123456,
                     categories: [String]? = [],
                     brands: [String]? = [],
                     authors: [String]? = [],
                     url: String? = "https://www.fairfaxstatic.com.au/content/dam/images/h/1/c/r/k/7/image.imgtype.afrWoodcutAuthorImage.140x140.png/1553476792466.png",
                     lastModified: Int? = 1553476792466,
                     sponsored: Bool? = false,
                     description: String? = "Some test description",
                     photographer: String? = "Winricke Kolbe",
                     type: String? = "afrArticleLead",
                     width: CGFloat? = 500,
                     height: CGFloat? = 500,
                     assetType: Article.AssetType? = .IMAGE,
                     xLarge2x: String? = "https://somexLarge2x.com",
                     large2x: String? = "https://someLarge2x.com",
                     large: String? = "https://someLarge.com",
                     thumbnail: String? = "https://someThumbnail.com",
                     timeStamp: Int? = 1678057442936) -> Self {
        RelatedImage(id: id,
                     categories: categories,
                     brands: brands,
                     authors: authors,
                     url: url,
                     lastModified: lastModified,
                     sponsored: sponsored,
                     description: description,
                     photographer: photographer,
                     type: type,
                     width: width,
                     height: height,
                     assetType: assetType,
                     xLarge2x: xLarge2x,
                     large2x: large2x,
                     large: large,
                     thumbnail: thumbnail,
                     timeStamp: timeStamp)
    }
}
