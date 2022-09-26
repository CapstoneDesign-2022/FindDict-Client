//
//  LogInVC.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/25.
//

import UIKit
import SnapKit
import Then

class LogInVC: AuthBaseVC {
    private let signInTextField = UITextField().then{
        $0.textColor = .textGray
        $0.backgroundColor = .textFieldGray
        $0.placeholder = "아이디"
        $0.layer.cornerRadius = 11
    }
    
    private let passwordTextField = UITextField().then{
        $0.textColor = .textGray
        $0.backgroundColor = .textFieldGray
        $0.placeholder = "비밀번호"
        $0.layer.cornerRadius = 11
    }
    
    private let signInButton = UIButton().then{
        $0.backgroundColor = .buttonYellow
        $0.setTitle("로그인", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.layer.cornerRadius = 24
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
}

extension LogInVC {
    private func setLayout() {
        view.addSubViews([super.logoImage, super.containerView, super.homeImage, signInTextField, passwordTextField, signInButton])
        
        super.logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(119)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        super.homeImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(48)
            $0.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-47)
        }
        
        super.containerView.snp.makeConstraints{
            $0.top.equalTo(super.logoImage.snp.bottom).offset(76)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(339)
//            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-161)
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