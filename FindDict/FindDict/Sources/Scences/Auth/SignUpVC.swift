//
//  SignUpVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/25.
//

import UIKit
import SnapKit
import Then

class SignUpVC: AuthBaseVC {
    
    // MARK: - Properties
    private let idTextField = TextField().then{
        $0.placeholder = "아이디"
    }
    
    private let idCheckButton = UIButton().then{
        $0.backgroundColor = .buttonOrange
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("중복 확인", for: .normal)
        $0.layer.cornerRadius = 24
    }
    
    lazy var textFieldStackView = UIStackView(arrangedSubviews: [ageTextField, passwordTextField,passwordConfirmTextField]).then {
        $0.axis = .vertical
        $0.spacing = 18
        $0.distribution = .fillEqually
    }
    
    private let ageTextField = TextField().then{
        $0.placeholder = "나이"
    }
    
    private let passwordTextField = TextField().then{
        $0.placeholder = "비밀번호"
    }
    
    private let passwordConfirmTextField = TextField().then{
        $0.placeholder = "비밀번호 확인"
    }
    
    private let signUpButton = UIButton().then{
        $0.backgroundColor = .buttonYellow
        $0.setTitleColor(.black, for: .normal)
        $0.setTitle("회원가입하기", for: .normal)
        $0.layer.cornerRadius = 24
        
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
    }
    


}

extension SignUpVC {
    private func setLayout(){
        view.addSubViews([idTextField,idCheckButton,ageText, passwordText, passwordConfirmText, signUpButton])
    
    containerView.snp.makeConstraints{
        $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(317)
        $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-317)
        $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(151)
    }
    
        idTextField.snp.makeConstraints{
            $0.top.equalTo(containerView.snp.top).offset(45)
            $0.leading.equalTo(containerView.snp.leading).offset(88)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-208)
            $0.height.equalTo(50)
        }
        idCheckButton.snp.makeConstraints{
                $0.top.equalTo(containerView.snp.top).offset(45)
                $0.bottom.equalTo(idTextField.snp.bottom).offset(0)
                $0.leading.equalTo(idTextField.snp.trailing).offset(18)
                $0.trailing.equalTo(containerView.snp.trailing).offset(-88)
            
        }
        ageText.snp.makeConstraints{
                $0.top.equalTo(idTextField.snp.bottom).offset(18)
                $0.leading.equalTo(containerView.snp.leading).offset(88)
                $0.trailing.equalTo(containerView.snp.trailing).offset(-88)
            $0.height.equalTo(50)
        }

        passwordText.snp.makeConstraints{
                $0.top.equalTo(ageText.snp.bottom).offset(18)
                $0.leading.equalTo(containerView.snp.leading).offset(88)
                $0.trailing.equalTo(containerView.snp.trailing).offset(-88)
            $0.height.equalTo(50)
        }
        passwordConfirmText.snp.makeConstraints{
                $0.top.equalTo(passwordText.snp.bottom).offset(18)
                $0.leading.equalTo(containerView.snp.leading).offset(88)
                $0.trailing.equalTo(containerView.snp.trailing).offset(-88)
            $0.height.equalTo(50)
        }
        signUpButton.snp.makeConstraints{
                $0.top.equalTo(passwordConfirmText.snp.bottom).offset(21)
                $0.leading.equalTo(containerView.snp.leading).offset(137)
                $0.trailing.equalTo(containerView.snp.trailing).offset(-137)
            $0.height.equalTo(56)
        }
    }
}
