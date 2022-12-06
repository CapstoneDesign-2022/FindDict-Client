//
//  CGRect+.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/16.
//
//
import UIKit

extension CGRect {
    func toString(digit: Int) -> String {
        let xStr = String(format: "%.\(digit)f", origin.x)
        let yStr = String(format: "%.\(digit)f", origin.y)
        let wStr = String(format: "%.\(digit)f", width)
        let hStr = String(format: "%.\(digit)f", height)
        return "(\(xStr), \(yStr), \(wStr), \(hStr))"
    }
}
