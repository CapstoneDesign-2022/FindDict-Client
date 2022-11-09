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
    
    private let passwordVerificationLabel = UILabel().then{
        $0.font = .findDictB7R12
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
        passwordTextField.setPWSecureButton()
        passwordConfirmTextField.setPWSecureButton()
        
        setTextFieldDelegate()
        setNotificationCenter()
        setButtonActions()
    }
    
    private func setButtonActions(){
        signUpButton.press{
            self.requestPostSignUp(data: SignUpBodyModel(user_id: self.idTextField.text ?? "", age: self.ageTextField.text ?? "", password: self.passwordTextField.text ?? ""))
        }
    }
    
}

// MARK: - UI
extension SignUpVC {
    private func setLayout(){
        view.addSubViews([idTextField,idCheckButton,textFieldStackView,passwordVerificationLabel,signUpButton])
        
        containerView.snp.makeConstraints{
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(317)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-317)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(80)
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
        textFieldStackView.snp.makeConstraints{
            $0.top.equalTo(idTextField.snp.bottom).offset(18)
            $0.leading.equalTo(containerView.snp.leading).offset(88)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-88)
            $0.height.equalTo(180)
        }
        
        passwordVerificationLabel.snp.makeConstraints{
            $0.top.equalTo(textFieldStackView.snp.bottom).offset(10)
            $0.leading.equalTo(containerView.snp.leading).offset(88)
            $0.height.equalTo(15)
        }
        
        signUpButton.snp.makeConstraints{
            $0.top.equalTo(passwordVerificationLabel.snp.bottom).offset(10)
            $0.leading.equalTo(containerView.snp.leading).offset(137)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-137)
            $0.height.equalTo(56)
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignUpVC: UITextFieldDelegate{
    
    func setTextFieldDelegate(){
        idTextField.delegate = self
        ageTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
    }
    
    func setNotificationCenter(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name:  UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (passwordTextField.text?.isEmpty ?? true || passwordConfirmTextField.text?.isEmpty ?? true) {return};
        if(passwordTextField.text == passwordConfirmTextField.text ) {
            passwordVerificationLabel.text = "입력한 비밀번호와 일치합니다."
            passwordVerificationLabel.textColor = .systemBlue
        }else{
            passwordVerificationLabel.text = "입력한 비밀번호와 일치하지 않습니다."
            passwordVerificationLabel.textColor = .systemRed
        }
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


extension SignUpVC{
    private func requestPostSignUp(data: SignUpBodyModel) {
        
        SignUpAPI.shared.postSignUp(body: data) { networkResult in
            switch networkResult {
                
            case .success(let response):
                if let res = response as? SignUpResponseModel {
//                    print()
//                    UserToken.shared.accessToken = res.accessToken
//                    self.carouselData = res
//                    self.requestGetMumentForTodayData()
                // TODO: - 회원가입 성공 알러트 창 띄우기
                    self.navigationController?.pushViewController(SignInVC(), animated: true)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
