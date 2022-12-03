//
//  GameResultButton.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/07.
//

import UIKit

class GameResultButton: UIButton {

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
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.25
    }
}

