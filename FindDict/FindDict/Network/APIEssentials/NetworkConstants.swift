//
//  NetworkConstants.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/01.
//

import Foundation
import Alamofire

/*
 NetworkConstants : 서버통신과정에서 필요한 상수들을 관리 -> header 관련 상수들
 */

enum HeaderType {
    case basic
    case withToken
    case multiPart
    case multiPartWithToken
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case accesstoken = "authorization"
}

enum ContentType: String {
    case json = "Application/json"
    case multiPart = "multipart/form-data"
    
    /// 임의로 고정시켜두는 accessToken 값입니다.
    case tokenSerial = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjozM30sImlhdCI6MTY2ODQxOTcyMywiZXhwIjoxNjY5NjI5MzIzfQ.QrDCRNSXILaexqswXB8H9Yri_g6qMAdaLYlK3Qr0RbE"
}
