//
//  UIButton+.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/26.
//

import UIKit

extension UIButton{
    func press(vibrate: Bool = false, for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        if #available(iOS 14.0, *) {
            self.addAction(UIAction { (action: UIAction) in closure()
                self.clickedAnimation(vibrate: vibrate)
            }, for: controlEvents)
        } else {
            @objc class ClosureSleeve: NSObject {
                let closure:()->()
                init(_ closure: @escaping()->()) { self.closure = closure }
                @objc func invoke() { closure() }
            }
            let sleeve = ClosureSleeve(closure)
            self.addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
            objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    /**
     해당 함수를 통해서 Poppin 효과를 처리합니다.
     - Description:
     줄어드는 정도를 조절하고싶다면 ,ScaleX,Y값을 조절합니다(최대값 1).
     낮을수록 많이 줄어듦.
     */
    func clickedAnimation(vibrate: Bool) {
        if vibrate { makeVibrate(degree: .light) }
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) }, completion: { (finish: Bool) in
                UIView.animate(withDuration: 0.1, animations: {
                    self.transform = CGAffineTransform.identity
                })
            }
        )
    }
}
