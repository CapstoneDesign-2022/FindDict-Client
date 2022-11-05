//
//  speechButton.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/04.
//

import UIKit

class SpeechButton: UIButton {
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUI()
    }

    // MARK: - Functions
    func setUI(){
        self.titleLabel?.font = .findDictH4R24
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 20
        self.backgroundColor = .modalButtonLightYellow
    }
}
