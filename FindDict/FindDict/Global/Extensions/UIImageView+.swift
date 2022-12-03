//
//  UIImageVIew+.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/14.
//

import UIKit

extension UIImageView {
    func load(_ URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image.resizeImage()
                    }
                }
            }
        }
    }
    
    var contentClippingRect: CGRect {
            guard let image = image else { return bounds }
            guard contentMode == .scaleAspectFit else { return bounds }
            guard image.size.width > 0 && image.size.height > 0 else { return bounds }

            let scale: CGFloat
            if image.size.width > image.size.height {
                scale = bounds.width / image.size.width
            } else {
                scale = bounds.height / image.size.height
            }

            let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            let x = (bounds.width - size.width) / 2.0
            let y = (bounds.height - size.height) / 2.0

            return CGRect(x: x, y: y, width: size.width, height: size.height)
        }
}
