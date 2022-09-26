//
//  AuthBaseVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/21.
//

import UIKit
import SnapKit
import Then

class AuthBaseVC: UIViewController {
    
    // MARK: - Properties
    internal let logoImage = UIImageView().then{
        $0.image = UIImage(named: "authImage")
    }
    internal let containerView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24

    }
        // 텍스트 필드 -> component
        // 회원가입하기, 로그인 버튼
    
    // 홈 버튼
    let homeImage = UIImageView().then {
        $0.image = UIImage(named: "homeImage")
    }

    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgYellow
    }
    

}


// MARK: - UI
extension AuthBaseVC {
    private func setLayout(){
        view.addSubViews([logoImage, containerView])
        
        logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        containerView.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(70)
            
        }
    }
}
