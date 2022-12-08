//
//  PhotoReSelectVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/22.
//

import UIKit
import SnapKit
import Then

final class PhotoReselectModalVC: UIViewController {
    
    // MARK: - Properties
    private let modalView: UIView = UIView().then{
        $0.backgroundColor = .bgBeige
        $0.addShadow(location: .bottom)
    }
    private let alertImageView: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "alertImage")
    }
    private let closeButton: UIButton = UIButton().then{
        $0.setImage(UIImage(named: "closeImage"), for: .normal)
    }
    private let alertTitleLabel: UILabel = UILabel().then{
        $0.text = "사진에 있는 단어가 부족해요.\n새로운 사진을 넣어봐요!"
        $0.numberOfLines = 2
        $0.textAlignment = .center
        $0.font = .findDictB2R24
        $0.textColor = .black
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgModal
        setButtonActions()
    }
    
    // MARK: - Functions
    private func setButtonActions(){
        closeButton.press{
            self.dismiss(animated: true, completion: nil)
        }
    }

}

// MARK: -UI
extension PhotoReselectModalVC {
    private func setLayout() {
        view.addSubViews([modalView, alertImageView,closeButton,alertTitleLabel])
        modalView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(250)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(321)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(321)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(230)
        }
        alertImageView.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(10)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(30)
            $0.trailing.equalTo(modalView.snp.trailing).inset(25)
        }
        alertTitleLabel.snp.makeConstraints{
            $0.top.equalTo(alertImageView.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

