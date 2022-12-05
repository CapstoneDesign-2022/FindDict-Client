//
//  SignInVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/21.
//

import UIKit
import SnapKit
import Then

class BeforeSignInVC: UIViewController {
    
    // MARK: - Properties
    private let logoImageView: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "logoImage")
        $0.contentMode = .scaleAspectFit
    }
    
    private let signInButton: UIButton = MainButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .buttonOrange
    }
    
    private let signUpButton: UIButton = MainButton().then{
        $0.setTitle("회원 가입", for: .normal)
        $0.backgroundColor = .buttonYellow
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgYellow
        setButtonActions()
    }
    
    // MARK: - Functions
    private func setButtonActions(){
        signInButton.press{
            let signInVC = SignInVC()
            self.navigationController?.pushViewController(signInVC, animated: true)
        }
        signUpButton.press{
            let signUpVC = SignUpVC()
            self.navigationController?.pushViewController(signUpVC, animated: true)
        }
    }
}


// MARK: - UI
extension BeforeSignInVC {
    private func setLayout(){
        view.addSubViews([logoImageView, signInButton, signUpButton])
        
        logoImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(190)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(120)
        }
        signInButton.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
//            $0.width.equalTo(300)
//            $0.height.equalTo(120)
        }
        signUpButton.snp.makeConstraints{
            $0.top.equalTo(signInButton.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
//            $0.width.equalTo(300)
//            $0.height.equalTo(120)
        }
    }
}
