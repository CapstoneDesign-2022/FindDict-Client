//
//  TextField.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/26.
//

import UIKit

class TextField: UITextField {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI(){
        self.backgroundColor = .textFieldGray
        self.layer.cornerRadius = 11
        self.addLeftPadding(10)
    }
}
