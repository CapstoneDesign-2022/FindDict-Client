//
//  UIView+.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/21.
//

import UIKit

extension UIView {
    func addSubViews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
