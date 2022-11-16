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
    }
    
    private let signInButton: UIButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .buttonOrange
        $0.titleLabel?.font = .findDictH4R35
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 10
    }
    
    private let signUpButton: UIButton = UIButton().then{
        $0.setTitle("회원 가입", for: .normal)
        $0.backgroundColor = .buttonYellow
        $0.titleLabel?.font = .findDictH4R35
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 10
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        signInButton.snp.makeConstraints{
            $0.top.equalTo(logoImageView.snp.bottom).offset(50)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
            $0.height.equalTo(120)
        }
        signUpButton.snp.makeConstraints{
            $0.top.equalTo(signInButton.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(300)
            $0.height.equalTo(120)
        }
    }
}
