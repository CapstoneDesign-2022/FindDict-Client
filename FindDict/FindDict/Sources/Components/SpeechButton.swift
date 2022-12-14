//
//  speechButton.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/04.
//

import UIKit

final class SpeechButton: UIButton {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUI()
    }

    // MARK: - UI
    private func setUI(){
        self.titleLabel?.font = .findDictB2R24
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 20
        self.backgroundColor = .fdLightYellow
        self.addShadow(location: .bottom)
    }
}
