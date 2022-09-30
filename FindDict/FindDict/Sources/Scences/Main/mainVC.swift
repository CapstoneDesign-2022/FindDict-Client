//
//  mainVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/29.
//

import UIKit
import SnapKit
import Then

class mainVC: UIViewController {
    
    // MARK: - Properties
    private let logoImage = UIImageView().then{
        $0.image = UIImage(named: "logoImage")
    }
    private let gameStartButton = MainButton().then{
        $0.backgroundColor = .buttonOrange
        $0.setTitle("게임 시작", for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight:  .bold)
    }
    
    lazy var buttonStackView = UIStackView(arrangedSubviews: [gameRuleButton, dictionaryButton]).then {
            $0.axis = .horizontal
            $0.spacing = 66
            $0.distribution = .fillEqually
        }

    private let gameRuleButton = MainButton().then{
        $0.backgroundColor = .buttonYellow
        $0.setTitle("게임 방법", for: .normal)
    }
    private let dictionaryButton = MainButton().then{
        $0.backgroundColor = .buttonYellow
        $0.setTitle("단어장", for: .normal)
    }

    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgYellow
    }

}

// MARK: - UI
extension mainVC {
    private func setLayout(){
        view.addSubViews([logoImage,gameStartButton, buttonStackView])
        
        logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(137)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        gameStartButton.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(73.5)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(447)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(gameStartButton.snp.bottom).offset(44)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(260)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(260)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(83)
            $0.height.equalTo(120)
        }
        
    }
    
}
