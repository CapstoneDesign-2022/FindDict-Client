//
//  SignInDataModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/01.
//

import Foundation

struct SignInResponseModel: Codable {
    let accessToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "accessToken"
    }
}
