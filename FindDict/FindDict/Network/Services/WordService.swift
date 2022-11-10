//
//  WordService.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/10.
//

import Alamofire

enum WordService {
    case getWordList
}

extension WordService: TargetType {
    var path: String {
        switch self {
        case .getWordList:
            return "/word/list"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWordList:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getWordList:
            return .withToken
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getWordList:
            return .requestPlain
        }
    }
}
