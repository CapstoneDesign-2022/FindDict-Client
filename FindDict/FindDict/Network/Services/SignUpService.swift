//
//  SignUpService.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/09.
//

import Alamofire

enum SignUpService {
    case postSignUp(body: SignUpBodyModel)
}

extension SignUpService: TargetType {
    var path: String {
        switch self {
        case .postSignUp:
            return "/auth/signUp"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postSignUp:
            return .post
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postSignUp:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postSignUp(let body):
            return .requestBody(["user_id": body.user_id, "age": body.age, "password": body.password])
        }
    }
}
