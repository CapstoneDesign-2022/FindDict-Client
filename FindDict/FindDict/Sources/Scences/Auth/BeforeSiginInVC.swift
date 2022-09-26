//
//  SignInVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/21.
//

import UIKit
import SnapKit
import Then

class BeforeSiginInVC: UIViewController {
    
    private let logoImage = UIImageView().then{
        $0.image = UIImage(named: "logoImage")
    }
    private let signInButton = UIButton().then{
        $0.setTitle("로그인", for: .normal)
        $0.backgroundColor = .buttonOrange
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight:  .bold)
        $0.layer.cornerRadius = 10
    }
    private let signUpButton = UIButton().then{
        $0.setTitle("회원 가입", for: .normal)
        $0.backgroundColor = .buttonYellow
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 48, weight:  .bold)
        $0.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgYellow
        // Do any additional setup after loading the view.
    }
    
    
}

extension BeforeSiginInVC {
    private func setLayout(){
        view.addSubViews([logoImage, signInButton, signUpButton])
        
        logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(137)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        signInButton.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(70)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        signUpButton.snp.makeConstraints{
            $0.top.equalTo(signInButton.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
