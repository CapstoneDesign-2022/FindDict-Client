//
//  UserToken.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/09.
//

import Foundation

class UserToken {
    
    /// 유저 토큰 관리를 위한 싱글톤 객체 선언
    static let shared = UserToken()
    
    var accessToken: String?
    var refreshToken: String?
    var getAccessToken: String { return self.accessToken ?? ContentType.tokenSerial.rawValue}
    
    private init() { }
}
