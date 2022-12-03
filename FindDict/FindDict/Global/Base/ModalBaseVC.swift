//
//  ModalBaseVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/05.
//

import UIKit
import SnapKit
import Then

class ModalBaseVC: UIViewController {
    
    // MARK: - Properties
    internal let modalView: UIView = UIView().then{
        $0.backgroundColor = .modalGray
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    internal let resultTitleLabel: UILabel = UILabel().then{
        $0.font = .findDictH5R48
        $0.textColor = .modalBrown
        $0.backgroundColor = .modalButtonLightYellow
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.textAlignment = .center
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    internal let resultImage: UIImageView = UIImageView()
    internal let retryButton: GameResultButton = GameResultButton().then {
        $0.layer.cornerRadius = 10
        $0.setTitle("다시 게임하기", for: .normal)
        $0.backgroundColor = .modalButtonDarkYellow
        $0.titleLabel?.font = .findDictH4R35
        $0.snp.makeConstraints{
            $0.height.equalTo(129)
        }
        
    }
    internal let dictionaryButton: GameResultButton = GameResultButton().then{
        $0.layer.cornerRadius = 10
        $0.setTitle("단어장", for: .normal)
        $0.backgroundColor = .modalButtonLightYellow
        $0.titleLabel?.font = .findDictH4R24
    }
    internal let mainViewButton: GameResultButton = GameResultButton().then{
        $0.layer.cornerRadius = 10
        $0.setTitle("메인화면", for: .normal)
        $0.backgroundColor = .modalButtonLightYellow
        $0.titleLabel?.font = .findDictH4R24
    }
    
    lazy var bottomButtonStackView: UIStackView = UIStackView(arrangedSubviews: [dictionaryButton, mainViewButton]).then{
        $0.axis = .horizontal
        $0.spacing = 5
        $0.distribution = .fillEqually
        
    }
    
    lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [retryButton, bottomButtonStackView]).then{
        $0.axis = .vertical
        $0.spacing = 33
    }
    
    var navigation: UINavigationController?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        view.backgroundColor = .bgModal
    }
    
    init(navigationController: UINavigationController?){
        navigation = navigationController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func setButtonActions(){
        retryButton.press{
            self.dismiss(animated: true){
                self.navigation?.pushViewController(PhotoSelectorVC(), animated: false)
            }
        }
        
        dictionaryButton.press{
            self.dismiss(animated: true){
                self.navigation?.pushViewController(DictionaryVC(), animated: false)
            }
        }
        
        mainViewButton.press{
            self.dismiss(animated: true){
                self.navigation?.pushViewController(MainVC(), animated: false)
            }
        }
    }
}


// MARK: - UI
extension ModalBaseVC {
    private func setLayout(){
        view.addSubViews([modalView, resultTitleLabel, resultImage, buttonStackView])
        modalView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(183)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(91)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(91)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(116)
        }
        
        resultTitleLabel.snp.makeConstraints{
            $0.top.equalTo(modalView).offset(53)
            $0.centerX.equalTo(modalView)
            $0.leading.equalTo(modalView.snp.leading).inset(183)
            $0.trailing.equalTo(modalView.snp.trailing).inset(183)
            $0.height.equalTo(102)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(resultTitleLabel.snp.bottom).offset(29)
            $0.leading.equalTo(modalView.snp.leading).inset(570)
            $0.trailing.equalTo(modalView.snp.trailing).inset(130)
            $0.height.equalTo(231)
            $0.width.equalTo(312)
        }
        
        resultImage.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).inset(113)
            $0.trailing.equalTo(buttonStackView.snp.leading).offset(-21)
        }
    }
}
