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
    private let englishButton: UIButton = UIButton().then{
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
    
    private let koreanLabelBoundaryView: UIView = UIView().then {
        //        $0.addShadow(location: .bottom)
        //                $0.addShadow(location: .left)
        //                $0.addShadow(location: .right)
        //        $0.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 2.0)
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 15)
    }
    
    private let koreanLabel: UILabel = UILabel().then{
        //        $0.addShadow(location: .bottom)
        //        $0.addShadow(location: .left)
        //        $0.addShadow(location: .right)
        //        $0.addShadow(offset: CGSize(width: 0, height: -2),opacity: 0.2,radius: 2.0)
        //        $0.shadowColor
        //        $0.shadowColor = .black
        //        $0.shadowOffset = CGSize(width: 0, height: 4)
        
        //        $0.layer.shadowRadius = 4
        //        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        //        $0.layer.shadowColor = UIColor.black.cgColor
        //        $0.layer.shadowOpacity = 0.25
        //        $0.makeRounded(cornerRadius: 15)
        //        $0.sizeToFit()
        $0.textAlignment = .center
        //        $0.backgroundColor = .white
        $0.textColor = .black
        $0.text = "-"
        //
        //        $0.addShadow(location: .bottom)
        //                $0.addShadow(location: .left)
        //                $0.addShadow(location: .right)
        //        $0.backgroundColor = .white
        //        $0.makeRounded(cornerRadius: 15)
    }
    
    private var koreanLabelText: String = ""
    
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
        englishButton.setTitle(english, for: .normal)
        koreanLabelText = korean
    }
    
    func setButtonActions(){
        englishButton.press{
            self.delegate?.hintButtonClicked(korean: self.englishButton.currentTitle ?? "버튼 레이블 오류")
        }
    }
    
    func getTargetLabel()->String{
        return englishButton.currentTitle ?? "-"
    }
    
    func handleGussedRightView(){
        englishButton.isUserInteractionEnabled = false
        koreanLabel.text = koreanLabelText
        englishButton.backgroundColor = .buttonGray
    }
    
    func setDelegate(delegate: TargetComponentViewDelegate){
        self.delegate = delegate
    }
    
}

// MARK: - UI
extension TargetListComponentView {
    func setLayout() {
        self.addSubViews([englishButton
                          ,koreanLabelBoundaryView
                          ,koreanLabel])
        
        englishButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.height.equalTo(40)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        koreanLabelBoundaryView.snp.makeConstraints{
            $0.top.equalTo(englishButton.snp.bottom).offset(15)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        koreanLabel.snp.makeConstraints{
            $0.leading.equalTo(koreanLabelBoundaryView).offset(10)
            $0.trailing.equalTo(koreanLabelBoundaryView).inset(10)
            $0.center.equalTo(koreanLabelBoundaryView)
        }
    }
}
