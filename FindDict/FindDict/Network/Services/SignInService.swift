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
    case getSignIn(body: SignInBodyModel)
}

extension SignInService: TargetType {
    var path: String {
        switch self {
        case .getSignIn:
            return "/auth/signIn"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSignIn:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .getSignIn:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .getSignIn(let body):
            return .requestBody(["user_id": body.user_id, "password": body.password])
        }
    }
}
