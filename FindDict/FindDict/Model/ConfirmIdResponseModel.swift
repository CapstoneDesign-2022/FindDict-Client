//
//  ConfirmIdResponseModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/13.
//

import Foundation

struct ConfirmIdResponseModel: Codable {
    let message: String
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}
