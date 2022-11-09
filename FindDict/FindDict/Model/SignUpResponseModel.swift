//
//  SignUpResponseModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/09.
//

import Foundation

struct SignUpResponseModel: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
    }
}
