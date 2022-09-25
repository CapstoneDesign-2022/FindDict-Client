//
//  AuthBaseVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/21.
//

import UIKit

class AuthBaseVC: UIViewController {
    
    // 로고
    let logoImage = UIImageView().then{
        $0.image = UIImage(named: "authImage")
    }
    
    // 흰색 배경
    let containerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24
    }
        // 텍스트 필드 -> component
        // 회원가입하기, 로그인 버튼
    
    // 홈 버튼
    let homeImage = UIImageView().then {
        $0.image = UIImage(named: "homeImage")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgYellow
    }
    

}

extension AuthBaseVC {
    private func setLayout(){
//        view.addSubViews([logoImage, bgView])
        
        
    }
}
