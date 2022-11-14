//
//  WordService.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/10.
//

import Alamofire
import UIKit

enum WordService {
    case getWordList
    case getHint(search: String)
//    case postWord(body: CreateWordBodyModel)
}

extension WordService: TargetType {
    var path: String {
        switch self {
        case .getWordList:
            return "/word/list"
        case .getHint:
            return "/word"
//        case .postWord:
//            return "/word/new"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWordList:
            return .get
        case .getHint:
            return .get
//        case .postWord:
//            return .post
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getWordList:
            return .withToken
        case .getHint:
            return .withToken
//        case .postWord:
//            return .multiPartWithToken
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getWordList:
            return .requestPlain
        case .getHint(let search):
            return .query(["search": search])
//        case .postWord(let body):
//            return .requestBody(["words": body.words])
        }
    }
    
//    var multipart: MultipartFormData {
//        switch self {
//        case .postWord(let body, imageData):
//            for (key, value) in body {
//                MultipartFormData.append("\(value)")
//            }
//            if let image = imageData?.pngData() {
//                multipartFormData.append(image, withName: "image",fileName: "\(image).png", mimeType: "image/png")
//            }
//            return multipartFormData
//        }
//    }
}
