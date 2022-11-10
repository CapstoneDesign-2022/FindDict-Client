//
//  NetworkResult.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/01.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
