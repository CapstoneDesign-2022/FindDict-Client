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
        $0.backgroundColor = .fdBeige
        $0.addShadow(location: .bottom)
    }
    internal let resultTitleLabel: UILabel = UILabel().then{
        $0.font = .findDictH5R48
        $0.textColor = .fdBrown
        $0.backgroundColor = .fdLightYellow
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.textAlignment = .center
        $0.addShadow(location: .bottom)
    }
    internal let resultImage: UIImageView = UIImageView()
    internal let retryButton: GameResultButton = GameResultButton().then {
        $0.layer.cornerRadius = 20
        $0.setTitle("다시 게임하기", for: .normal)
        $0.backgroundColor = .fdDarkYellow
        $0.titleLabel?.font = .findDictH6R35
        $0.snp.makeConstraints{
            $0.height.equalTo(129)
        }
    }
    internal let dictionaryButton: GameResultButton = GameResultButton().then{
        $0.layer.cornerRadius = 20
        $0.setTitle("단어장", for: .normal)
        $0.backgroundColor = .fdLightYellow
        $0.titleLabel?.font = .findDictB2R24
    }
    internal let mainViewButton: GameResultButton = GameResultButton().then{
        $0.layer.cornerRadius = 20
        $0.setTitle("메인화면", for: .normal)
        $0.backgroundColor = .fdLightYellow
        $0.titleLabel?.font = .findDictB2R24
    }
    
    lazy var bottomButtonStackView: UIStackView = UIStackView(arrangedSubviews: [dictionaryButton, mainViewButton]).then{
        $0.axis = .horizontal
        $0.spacing = 10
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
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(160)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(90)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(90)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(116)
        }
        
        resultTitleLabel.snp.makeConstraints{
            $0.top.equalTo(modalView).offset(40)
            $0.centerX.equalTo(modalView)
            $0.width.equalTo(380)
            $0.height.equalTo(110)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(resultTitleLabel.snp.bottom).offset(70)
            $0.leading.equalTo(modalView.snp.leading).inset(570)
            $0.trailing.equalTo(modalView.snp.trailing).inset(120)
            $0.height.equalTo(230)
            $0.width.equalTo(320)
        }
        
        resultImage.snp.makeConstraints{
//            $0.top.equalTo(modalView.snp.top).inset(113)
            $0.top.equalTo(resultTitleLabel.snp.bottom).offset(-20)
            $0.trailing.equalTo(buttonStackView.snp.leading).offset(-40)
        }
    }
}
