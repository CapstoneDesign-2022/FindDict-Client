//
//  TargetListComponentView.swift
//  FindDict
//
//  Created by 김지민 on 2022/10/27.
//

import UIKit
import SnapKit
import Then


protocol TargetComponentViewDelegate: AnyObject {
    func hintButtonClicked(korean: String)
}

class TargetListComponentView: UIView {
    
    private var delegate: TargetComponentViewDelegate?
    private let koreanButton: UIButton = UIButton().then{
        if #available(iOS 15.0, *) {
            $0.configuration = .plain()
            $0.configuration?.buttonSize = .large
        } else {
            // Fallback on earlier versions
        }
        
        $0.makeRounded(cornerRadius: 20)
        
        $0.backgroundColor = .buttonYellow
        $0.setTitleColor(.black, for: .normal)
    }
    
    private let englishLabelBoundaryView: UIView = UIView().then {
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 15)
        $0.addShadow(location: .bottomRight)
    }
    
    private let englishLabel: UILabel = UILabel().then{
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "-"
    }
    
    private var englishLabelText: String = ""
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setButtonActions()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    // MARK: - Functions
    func setData(korean: String, english: String){
        koreanButton.setTitle(korean, for: .normal)
        englishLabelText = english
    }
    
    func setButtonActions(){
        koreanButton.press{
            self.delegate?.hintButtonClicked(korean: self.koreanButton.currentTitle ?? "버튼 레이블 오류")
        }
    }
    
    func getTargetLabel()->String{
        return englishLabelText
    }
    
    func handleGussedRightView(){
        koreanButton.isUserInteractionEnabled = false
        englishLabel.text = englishLabelText
        koreanButton.backgroundColor = .buttonGray
    }
    
    func setDelegate(delegate: TargetComponentViewDelegate){
            self.delegate = delegate
        }
    
}

// MARK: - UI
extension TargetListComponentView {
    func setLayout() {
        self.addSubViews([koreanButton
                          ,englishLabelBoundaryView
                          ,englishLabel])
        
        koreanButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        englishLabelBoundaryView.snp.makeConstraints{
            $0.top.equalTo(koreanButton.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        englishLabel.snp.makeConstraints{
            $0.leading.equalTo(englishLabelBoundaryView).offset(10)
            $0.trailing.equalTo(englishLabelBoundaryView).inset(10)
            $0.center.equalTo(englishLabelBoundaryView)
        }
    }
}
