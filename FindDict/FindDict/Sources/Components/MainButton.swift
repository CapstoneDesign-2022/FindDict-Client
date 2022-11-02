//
//  MainButton.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/29.
//

import UIKit

class MainButton: UIButton {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI(){
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 10
        self.titleLabel?.font = .findDictH4M48
    }
}
