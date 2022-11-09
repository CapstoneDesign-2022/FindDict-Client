//
//  SignInService.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/01.
//


/*
 AuthRouter : 여러 Endpoint들을 갖고 있는 enum
 TargetType을 채택해서 path, method, header, parameter를 각 라우터에 맞게 request를 만든다.
 */


import Alamofire

enum SignInService {
    case postSignIn(body: SignInBodyModel)
}

extension SignInService: TargetType {
    var path: String {
        switch self {
        case .postSignIn:
            return "/auth/signIn"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postSignIn:
            return .post
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postSignIn:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postSignIn(let body):
            return .requestBody(["user_id": body.user_id, "password": body.password])
        }
    }
}
