//
//  CreateWordBodyModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/11.
//

import Foundation

struct CreateWordBodyModel: Codable {
    var words: [Word]
    
    struct Word: Codable {
        var korean: String
        var english: String
    }
}
