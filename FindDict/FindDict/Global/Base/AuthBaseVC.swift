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
    internal let logoImage: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "authImage")
    }
    internal let containerView: UIView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 24

    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .fdLightYellow
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
