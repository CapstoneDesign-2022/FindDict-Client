//
//  TargetListComponentView.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/27.
//

import UIKit
import SnapKit
import Then

class TargetListComponentView: UIView {
    
    private var guessedRight = true

    private let koreanButton = UIButton().then{
        $0.makeRounded(cornerRadius: nil)
    }
    
    private let englishLabel = UILabel().then{
        $0.addShadow(location: .bottom)
        $0.addShadow(location: .left)
        $0.addShadow(location: .right)
        $0.backgroundColor = .white
        $0.textColor = .black
        $0.text = "-"
    }
    
    private var englishLabelText :String = ""
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Functions
    func setData(korean:String, english:String){
        koreanButton.setTitle(korean, for: .normal)
        englishLabelText = english
    }
    
    func setButtonActions(){
        koreanButton.press{
            print("힌트 보기")
        }
    }

}

extension TargetListComponentView {
    func setLayout() {
        self.addSubViews([koreanButton,englishLabel])
        
        koreanButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
        englishLabel.snp.makeConstraints{
            $0.top.equalTo(koreanButton.snp.bottom).offset(15)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
        
    }
}
