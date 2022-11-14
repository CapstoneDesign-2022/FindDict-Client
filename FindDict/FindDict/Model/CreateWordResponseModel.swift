//
//  CreateWordResponseModel.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/11.
//

import Foundation
import UIKit

struct CreateWordResponseModel: Codable {
    let english: String
    var image: UIImage? {
        return UIImage(named: english)
    }

    enum CodingKeys: String, CodingKey {
        case english = "english"
        case image = "image"
    }
}
