//
//  SignInDataModel.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/01.
//

import Foundation

struct SignInDataModel: Codable {
    let id: String
    let profileID: String
    let name: String
    let image: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case profileID = "profileId"
        case name = "name"
        case image = "image"
    }
}
