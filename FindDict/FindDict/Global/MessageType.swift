//
//  MessageType.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/09.
//

import Foundation

enum MessageType {
    case networkError
    case modelErrorForDebug
    case signUpSuccess
    case signInSuccess
    case signInFail
}

extension MessageType {
    var message: String {
        switch self {
        case .networkError:
            return """
네트워크 오류로 인해 연결에 실패했어요! 🥲
잠시 후에 다시 시도해 주세요.
"""
        case .modelErrorForDebug:
            return "🚨당신 모델이 이상해열~🚨"
            
        case .signUpSuccess:
            return "회원가입 성공입니다 😄"
            
        case .signInSuccess:
            return "로그인 성공 🤗"
            
        case .signInFail:
            return "로그인 실패 😿"
        }
    }
}
