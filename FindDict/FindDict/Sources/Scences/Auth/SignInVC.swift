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
        setTextFieldDelegate()
        setNotificationCenter()
        setButtonActions()
    }
    
    private func setButtonActions(){
        signInButton.press{
            self.requestGetSignIn(data: SignInBodyModel(user_id: self.signInTextField.text ?? "", password: self.passwordTextField.text ?? ""))
        }
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

// MARK: - UITextFieldDelegate
extension SignInVC: UITextFieldDelegate{
    
    func setTextFieldDelegate(){
        signInTextField.delegate = self
        passwordTextField.delegate = self
    }

    func setNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    func keyboardWillShow(_ sender:Notification) {
        self.view.frame.origin.y = -300
    }
    
    @objc
    func keyboardWillHide(_ sender:Notification) {
        self.view.frame.origin.y = 0 
    }
}

extension SignInVC{
    private func requestGetSignIn(data: SignInBodyModel) {
        
        AuthAPI.shared.postSignIn(body: data) { networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? SignInResponseModel {
                    print(res)
                    UserToken.shared.accessToken = res.accessToken
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
