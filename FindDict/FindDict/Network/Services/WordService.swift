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
        }
    }
    
    var multipart: MultipartFormData {
        switch self {
        case .postWord(let body, let image):
            let multiPart = MultipartFormData()
//
//            multiPart.append(Data(String(body.image).utf8), withName: "score")
//            multiPart.append(Data(taste.utf8), withName: "taste")
//            good.forEach {
//                let data = Data(String($0).utf8)
//                multiPart.append(data, withName: "good")
//            }
//            multiPart.append(Data(content.utf8), withName: "content")
//            for (index, item) in image.enumerated() {
//                if let imageData = item.pngData() {
//                    multiPart.append(imageData, withName: "image", fileName: "image\(index).png", mimeType: "image/png")
//                }
//            }
            
            multiPart.append(Data(body.english.utf8), withName: "english")
            guard let imageData = image.pngData() else { return MultipartFormData() }
            multiPart.append(imageData, withName: "image", fileName: "image\(body.english).png", mimeType: "image/png")
//            for (index, item) in body.image.enumerated() {
//                if let imageData = item.pngData() {
//
//                }
//            }
            return multiPart
        
        default: return MultipartFormData()
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
