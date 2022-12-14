//
//  BaseAPI.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/01.
//

import Foundation
import Alamofire

class BaseAPI {
    enum TimeOut {
        static let requestTimeOut: Float = 30
        static let resourceTimeOut: Float = 30
    }
    
    let AFmanager: Session = {
        var session = AF
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = TimeInterval(TimeOut.requestTimeOut)
        configuration.timeoutIntervalForResource = TimeInterval(TimeOut.resourceTimeOut)
        
        let eventLogger = APIEventLogger()
        session = Session(configuration: configuration, eventMonitors: [eventLogger])
        return session
    }()
    
    func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(GenericResponse<T>.self, from: data)
        else { return .pathErr }
        switch statusCode {
        case 200...201:
            return .success(decodedData.data ?? "None-Data")
        case 202..<300:
            return .success(decodedData.status)
        case 400..<500:
            return .requestErr(decodedData.status)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
    
    func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200...201:
            return .success(data)
        case 202..<300:
            return .success(statusCode)
        case 400..<500:
            return .requestErr(statusCode)
        case 500:
            return .serverErr
        default:
            return .networkFail
        }
    }
}
