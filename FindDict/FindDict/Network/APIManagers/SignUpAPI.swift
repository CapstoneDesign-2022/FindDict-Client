//
//  SignUpAPI.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/09.
//

import Foundation
import Alamofire

class SignUpAPI: BaseAPI {
    static let shared = SignUpAPI()
    
    private override init() { }
    
    /// [POST] 회원가입
    func postSignUp(body: SignUpBodyModel,
                    completion: @escaping (NetworkResult<Any>) -> (Void)) {
        AFmanager.request(SignUpService.postSignUp(body: body)).responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let data = response.data else { return }
                let networkResult = self.judgeStatus(by: statusCode, data, SignUpBodyModel.self)
                completion(networkResult)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
