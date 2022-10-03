//
//  UITableViewCell+.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/01.
//

import UIKit

extension UITableViewCell {
    open override func addSubview(_ view: UIView) {
        super.addSubview(view)
        sendSubviewToBack(contentView)
    }
}
