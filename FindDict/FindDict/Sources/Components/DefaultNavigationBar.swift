//
//  DefaultNavigationBar.swift
//  FindDict
//
//  Created by 김지민 on 2022/12/07.
//


import UIKit
import SnapKit
import Then

protocol DefaultNavigationBarDelegate{
    func backButtonClicked()
    func homeButtonClicked()
}

final class DefaultNavigationBar: UIView {
    
    // MARK: - Properties
    private var delegate: DefaultNavigationBarDelegate?
    
    private let backButton = UIButton().then {
        $0.setImage(UIImage(named: "left_arrow"), for: .normal)
    }
    
    private let logoImage = UIImageView().then{
        $0.image = UIImage(named: "icon")
        $0.contentMode = .scaleAspectFit
    }
    
    private let titleLabel = UILabel().then {
        $0.textColor = .black
        $0.font = .findDictH3B36
    }
    
    private let homeButton = UIButton().then {
        $0.setImage(UIImage(named: "home"), for: .normal)
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    init(isHomeButtonIncluded: Bool = true) {
        super.init(frame: .zero)
        setLayout()
        if (isHomeButtonIncluded){
            setHomeButtonLayout()
        }
        setButtonActions()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    //MARK: - Functions
    func setDelegate(delegate: DefaultNavigationBarDelegate){
        self.delegate = delegate
    }
    
    func setTitleLabel(title: String) {
        self.titleLabel.text = title
    }
    
    private func setButtonActions(){
        backButton.press{
            self.delegate?.backButtonClicked()
        }
        
        homeButton.press{
            self.delegate?.homeButtonClicked()
        }
    }
}

// MARK: - UI
extension DefaultNavigationBar {

    private func setLayout() {
        
        self.addSubViews([backButton, logoImage, titleLabel])
        backButton.snp.makeConstraints {
            $0.left.equalTo(self.safeAreaLayoutGuide).offset(30)
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(self.safeAreaLayoutGuide)
        }
        
        logoImage.snp.makeConstraints {
            $0.right.equalTo(titleLabel.snp.left).inset(50)
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
    }
    
    private func setHomeButtonLayout() {
        self.addSubViews([homeButton])
       
        homeButton.snp.makeConstraints {
            $0.right.equalTo(self.safeAreaLayoutGuide).inset(40)
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
        }
    }
}
