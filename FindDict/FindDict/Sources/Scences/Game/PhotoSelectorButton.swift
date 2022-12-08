//
//  PhotoSelectorButton.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/27.
//

import UIKit

class PhotoSelectorButton: UIButton {

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    // MARK: - UI
    private func setUI(){
        self.layer.cornerRadius = 35
        self.titleLabel?.font = .findDictH4R35
        self.setTitleColor(.black, for: .normal)
        self.addShadow(location: .bottomRight)
    }
}
