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
    case postWord(body: CreateWordBodyModel, image: UIImage)
    case getWordDetail(word: String)
}

extension WordService: TargetType {
    var path: String {
        switch self {
        case .getWordList:
            return "/word/list"
        case .getHint:
            return "/word"
        case .postWord:
            return "/word/new"
        case .getWordDetail:
            return "/word/detail"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWordList:
            return .get
        case .getHint:
            return .get
        case .postWord:
            return .post
        case .getWordDetail:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getWordList:
            return .withToken
        case .getHint:
            return .withToken
        case .postWord:
            return .multiPartWithToken
        case .getWordDetail:
            return .withToken
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getWordList:
            return .requestPlain
        case .getHint(let search):
            return .query(["search": search])
        case .postWord(let body,_):
            return .requestBody(["english": body.english])
        case .getWordDetail(let word):
            return .query(["word": word])
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .postWord(let body, let image):
            let multiPart = MultipartFormData()
            multiPart.append(Data(body.english.utf8), withName: "english")
            guard let imageData = image.pngData() else { return MultipartFormData() }
            multiPart.append(imageData, withName: "image", fileName: "image\(body.english).png", mimeType: "image/png")
            return multiPart
        
        default: return MultipartFormData()
        }
    }

}
