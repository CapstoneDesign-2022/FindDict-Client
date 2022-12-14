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

final class TargetListComponentView: UIView {
    
    // MARK: - Properties
    private var delegate: TargetComponentViewDelegate?
    
    // MARK: - UI Properties
    private let englishButton: UIButton = UIButton().then{
        if #available(iOS 15.0, *) {
            $0.configuration = .plain()
            $0.configuration?.buttonSize = .large
        }
        $0.makeRounded(cornerRadius: 20)
        $0.backgroundColor = .fdYellow
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 16.0)
    }
    
    private let koreanLabelBoundaryView: UIView = UIView().then {
        $0.backgroundColor = .white
        $0.makeRounded(cornerRadius: 15)
        $0.addShadow(location: .bottomRight)
    }
    
    private let koreanLabel: UILabel = UILabel().then{
        $0.textAlignment = .center
        $0.textColor = .black
        $0.text = "-"
    }
    
    private var koreanLabelText: String = ""
    private let containerView: UIView = UIView()
    
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
    func setDelegate(delegate: TargetComponentViewDelegate){
        self.delegate = delegate
    }
    
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
    
    func handleGuessedRightView(){
        koreanLabel.text = koreanLabelText
        
        englishButton.do{
            $0.isUserInteractionEnabled = false
            $0.backgroundColor = .fdGray
            $0.layer.shadowOpacity = 0
            $0.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 16.0)
        }

        containerView.snp.remakeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        englishButton.snp.remakeConstraints {
            $0.top.equalTo(containerView)
            $0.height.equalTo(40)
            $0.leading.equalTo(containerView).offset(10)
            $0.trailing.equalTo(containerView).inset(10)
        }
    }
    
    func enableEnglishButton() {
        englishButton.do{
            $0.isUserInteractionEnabled = true
            $0.backgroundColor = .fdOrange
            $0.titleLabel?.font = UIFont(name: "NotoSans-Bold", size: 18.0)
        }
        
        englishButton.snp.remakeConstraints {
            $0.height.equalTo(60)
            $0.width.equalToSuperview()
        }
    }
    
    func disableEnglishButton() {
        englishButton.do{
            $0.isUserInteractionEnabled = false
            $0.backgroundColor = .fdLightYellow
            $0.addShadow(location: .bottomRight)
            $0.titleLabel?.font = UIFont(name: "NotoSans-Regular", size: 16.0)
        }
        
        containerView.snp.makeConstraints {
            $0.width.equalTo(englishButton.frame.width + 30)
        }
    }
}

// MARK: - UI
extension TargetListComponentView {
    private func setLayout() {
        self.addSubViews([containerView])
        containerView.addSubViews([englishButton, koreanLabelBoundaryView, koreanLabel])
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(11)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
        
        englishButton.snp.makeConstraints {
            $0.top.equalTo(containerView)
            $0.height.equalTo(40)
            $0.leading.equalTo(containerView).offset(10)
            $0.trailing.equalTo(containerView).inset(10)
        }
        
        koreanLabelBoundaryView.snp.makeConstraints{
            $0.top.equalTo(englishButton.snp.bottom).offset(15)
            $0.leading.equalTo(containerView).offset(10)
            $0.trailing.equalTo(containerView).inset(10)
            $0.height.equalTo(40)
            $0.bottom.equalTo(containerView)
        }
        
        koreanLabel.snp.makeConstraints{
            $0.leading.equalTo(koreanLabelBoundaryView).offset(10)
            $0.trailing.equalTo(koreanLabelBoundaryView).inset(10)
            $0.center.equalTo(koreanLabelBoundaryView)
        }
    }
}
