//
//  HintResponseModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/10.
//

import Foundation

struct HintResponseModel: Codable {
    
    let images: [String]

    enum CodingKeys: String, CodingKey {
        case images = "images"
    }
}

