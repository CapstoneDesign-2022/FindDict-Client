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

enum AuthService {
    case postSignIn(body: SignInBodyModel)
    case postSignUp(body: SignUpBodyModel)
    case confirmId(user_id: String)
}

extension AuthService: TargetType {
    var path: String {
        switch self {
        case .postSignIn:
            return "/auth/signIn"
        case .postSignUp:
            return "/auth/signUp"
        case .confirmId:
            return "/auth/confirmId"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postSignIn:
            return .post
        case .postSignUp:
            return .post
        case .confirmId:
            return .get
        }
    }
    
    var header: HeaderType {
        switch self {
        case .postSignIn:
            return .basic
        case .postSignUp:
            return .basic
        case .confirmId:
            return .basic
        }
    }
    
    var parameters: RequestParams {
        switch self {
        case .postSignIn(let body):
            return .requestBody(["user_id": body.user_id, "password": body.password])
        case .postSignUp(let body):
            return .requestBody(["user_id": body.user_id, "age": body.age, "password": body.password])
        case .confirmId(let user_id):
            return .query(["user_id": user_id])
        }
    }
}
