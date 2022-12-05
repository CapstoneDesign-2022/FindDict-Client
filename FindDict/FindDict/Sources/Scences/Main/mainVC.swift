//
//  mainVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/29.
//

import UIKit
import SnapKit
import Then

class MainVC: UIViewController {
    
    // MARK: - Properties
    private let logoImage: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "logoImage")
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [gameStartButton, dictionaryButton, gameRuleButton]).then {
        $0.axis = .vertical
        $0.spacing = 25
    }
    
    private let gameStartButton: MainButton = MainButton().then{
        $0.backgroundColor = .buttonOrange
        $0.setTitle("게임 시작", for: .normal)
    }
    
    private let dictionaryButton: MainButton = MainButton().then{
        $0.backgroundColor = .buttonOrange
        $0.setTitle("단어장", for: .normal)
    }
    
    private let gameRuleButton: MainButton = MainButton().then{
        $0.backgroundColor = .buttonYellow
        $0.setTitle("게임 방법", for: .normal)
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        view.backgroundColor = .bgYellow
    }

    // MARK: - Functions
    func setButtonActions(){
        gameStartButton.press{
            let initiatingGameVC = PhotoSelectorVC()
            self.navigationController?.pushViewController(initiatingGameVC, animated: true)
        }
        
        gameRuleButton.press{
            self.navigationController?.pushViewController(GameTutorialVC(), animated: true)
        }
        
        dictionaryButton.press{
            let dictionaryVC = DictionaryVC()
            self.navigationController?.pushViewController(dictionaryVC, animated: true)
        }
    }
}

// MARK: - UI
extension MainVC {
    private func setLayout(){
        view.addSubViews([logoImage, buttonStackView])
        
        logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }

        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
