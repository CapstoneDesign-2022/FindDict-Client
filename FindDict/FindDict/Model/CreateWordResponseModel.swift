//
//  CreateWordResponseModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/11.
//

import Foundation

struct CreateWordResponseModel: Codable {
    let words: [Word] = []

    enum CodingKeys: String, CodingKey {
        case words = "words"
    }
    
    struct Word: Codable {
        let korean: String
        let english: String

        enum CodingKeys: String, CodingKey {
            case korean = "korean"
            case english = "english"
        }
    }
}
