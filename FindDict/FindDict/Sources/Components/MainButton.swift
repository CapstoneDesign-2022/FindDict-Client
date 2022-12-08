//
//  MainButton.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/29.
//

import UIKit

class MainButton: UIButton {

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
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 20
        self.titleLabel?.font = .findDictB1R28
        self.snp.makeConstraints{
            $0.width.equalTo(350)
            $0.height.equalTo(90)
        }
        self.addShadow(location: .bottomRight)
    }
}
