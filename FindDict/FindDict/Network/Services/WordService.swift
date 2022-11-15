//
//  WordService.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/10.
//

import Alamofire

enum WordService {
    case getWordList
    case getWordDetail(word: String)
}

extension WordService: TargetType {
    var path: String {
        switch self {
        case .getWordList:
            return "/word/list"
        case .getWordDetail:
            return "/word/detail"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWordList:
            return .get
        case .getWordDetail:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getWordList:
            return .withToken
        case .getWordDetail:
            return .withToken
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getWordList:
            return .requestPlain
        case .getWordDetail(let word):
            return .query(["word": word])
        }
    }
}
