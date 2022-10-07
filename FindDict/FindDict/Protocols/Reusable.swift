//
//  Reusable.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import Foundation

// identifier의 반복되는 선언을 덜어주는 프로토콜입니다
protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
