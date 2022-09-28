//
//  LogInVC.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/25.
//

import UIKit
import SnapKit
import Then

class SignInVC: AuthBaseVC {
    
    // MARK: - Properties
    private let signInTextField = TextField().then{
        $0.placeholder = "아이디"
    }
    
    private let passwordTextField = TextField().then{
        $0.placeholder = "비밀번호"
    }
    
    private let signInButton = UIButton().then{
        $0.backgroundColor = .buttonYellow
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 24
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        passwordTextField.setPWSecureButton()
    }
}

// MARK: - UI
extension SignInVC {
    private func setLayout() {
        view.addSubViews([signInTextField, passwordTextField, signInButton])
        
        super.containerView.snp.makeConstraints{
            $0.top.equalTo(super.logoImage.snp.bottom).offset(76)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(339)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-339)
        }
        
        signInTextField.snp.makeConstraints{
            $0.top.equalTo(containerView.snp.top).offset(67)
            $0.leading.equalTo(containerView.snp.leading).offset(60)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-60)
            $0.height.equalTo(50)
        }

        passwordTextField.snp.makeConstraints{
            $0.top.equalTo(signInTextField.snp.bottom).offset(17)
            $0.leading.equalTo(containerView.snp.leading).offset(60)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-60)
            $0.height.equalTo(50)
        }
        
        signInButton.snp.makeConstraints{
            $0.top.equalTo(passwordTextField.snp.bottom).offset(53)
            $0.bottom.equalTo(containerView.snp.bottom).offset(-109)
            $0.leading.equalTo(containerView.snp.leading).offset(85)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-85)
            $0.height.equalTo(56)
        }
    }
}
