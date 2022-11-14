//
//  HintModalVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/30.
//

import UIKit
import SnapKit
import Then


class HintModalVC: UIViewController {
    // MARK: - Properties
    private var images: [String] = [] {
        didSet{
            print(">>>>>>>>>>>>>>>",images)
            hintImageView1.load(images[0])
            hintImageView2.load(images[1])
            hintImageView3.load(images[2])
            hintImageView4.load(images[3])
            //            hintImageView2.load(
        }
    }
    private var korean: String = "" {
        didSet{
            requestGetHint(search: korean)
        }
    }
    
    private let modalView = UIView().then{
        $0.backgroundColor = .bgBeige
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    
    private let hintLabel = UILabel().then{
        $0.text = "HINT"
        $0.textColor = .black
        $0.font = .findDictH4R35
    }
    
    private let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closeImage"), for: .normal)
    }
    
    private let hintImageView1 = UIImageView().then{
        $0.image = UIImage(named: "globe")
    }
    
    private let hintImageView2 = UIImageView().then{
        $0.image = UIImage(named: "globe")
    }
    
    private let hintImageView3 = UIImageView().then{
        $0.image = UIImage(named: "globe")
    }
    
    private let hintImageView4 = UIImageView().then{
        $0.image = UIImage(named: "globe")
    }
    
    lazy var imageTopStackView = UIStackView(arrangedSubviews: [hintImageView1, hintImageView2]).then{
        $0.axis = .horizontal
        $0.spacing = 33
        $0.distribution = .fillEqually
    }
    
    lazy var imageBottomStackView = UIStackView(arrangedSubviews: [hintImageView3, hintImageView4]).then{
        $0.axis = .horizontal
        $0.spacing = 33
        $0.distribution = .fillEqually
    }
    
    lazy var imageStackView = UIStackView(arrangedSubviews: [imageTopStackView, imageBottomStackView]).then{
        $0.axis = .vertical
        $0.spacing = 21
        $0.distribution = .fillEqually
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgModal
        setButtonActions()
    }
    
    // MARK: - Functions
    func setButtonActions(){
        closeButton.press{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func setKoreanText(korean: String){
        self.korean = korean
    }
    
}

// MARK: - Network
extension HintModalVC {
    private func requestGetHint(search: String) {
        WordAPI.shared.getHint(search: search){ networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? HintResponseModel {
                    self.images = res.images
                    //                    UserToken.shared.accessToken = res.accessToken
                } else {
                    debugPrint(MessageType.modelErrorForDebug.message)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
        
    }
}


// MARK: - UI
extension HintModalVC {
    private func setLayout() {
        view.addSubViews([modalView, hintLabel, closeButton, imageStackView])
        modalView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(236)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(223)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(223)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(92)
        }
        hintLabel.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(4)
            $0.centerX.equalTo(modalView)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(16)
            $0.trailing.equalTo(modalView.snp.trailing).offset(-20)
            
        }
        imageStackView.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(75)
            $0.leading.equalTo(modalView.snp.leading).offset(59)
            $0.trailing.equalTo(modalView.snp.trailing).inset(59)
            $0.bottom.equalTo(modalView.snp.bottom).inset(18)
        }
        
    }
}
