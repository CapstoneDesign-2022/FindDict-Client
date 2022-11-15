//
//  WordDetailResponseModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/11.
//
import Foundation

struct WordDetailResponseModel: Codable {
    let urls: [ImageURL]
    
    enum CodingKeys: String, CodingKey {
        case urls = "urls"
    }
    
    struct ImageURL: Codable {
        let image_url: String

        enum CodingKeys: String, CodingKey {
            case image_url = "image_url"
        }
    }
}
//
//extension WordDetailResponseModel {
//    static let sampleData: [ImageURL] = [
//        ImageURL(image_url: "https://finddict.s3.ap-northeast-2.amazonaws.com/test/1665054395307_%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-10-03%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%2011.35.45.png"),
//        ImageURL(image_url: "https://finddict.s3.ap-northeast-2.amazonaws.com/test/1665054314880_%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA%202022-10-03%20%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE%2010.17.12.png"),
//    ]
//}
