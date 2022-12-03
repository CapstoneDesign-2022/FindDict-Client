//
//  WordListResponseModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/10.
//

import Foundation

struct WordListResponseModel: Codable {
    let english: [String]
    
    enum CodingKeys: String, CodingKey {
        case english = "english"
    }
}


extension WordListResponseModel {
    static let sampleData: [String] = [
        "dictionary",
        "apple"
    ]
}

