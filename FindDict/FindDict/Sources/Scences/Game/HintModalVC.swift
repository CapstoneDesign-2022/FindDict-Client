//
//  HintModalVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/30.
//

import UIKit
import SnapKit
import Then


final class HintModalVC: UIViewController {
    
    // MARK: - Properties
    private var images: [String] = [] {
        didSet{
            hintImageView1.load(images[0])
            hintImageView2.load(images[1])
            hintImageView3.load(images[2])
            hintImageView4.load(images[3])
        }
    }
    
    private var korean: String = "" {
        didSet{
            requestGetHint(search: korean)
        }
    }
    
    private let modalView: UIView = UIView().then{
        $0.backgroundColor = .fdBeige
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    
    private let hintLabel: UILabel = UILabel().then{
        $0.text = "HINT"
        $0.textColor = .black
        $0.font = .findDictH6R35
    }
    
    private let closeButton: UIButton = UIButton().then{
        $0.setImage(UIImage(named: "closeImage"), for: .normal)
    }
    
    private let hintImageView1: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "launchScreen")
        $0.addShadow(location: .bottom)
    }
    
    private let hintImageView2: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "launchScreen")
        $0.addShadow(location: .bottom)
    }
    
    private let hintImageView3: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "launchScreen")
        $0.addShadow(location: .bottom)
    }
    
    private let hintImageView4: UIImageView = UIImageView().then{
        $0.image = UIImage(named: "launchScreen")
        $0.addShadow(location: .bottom)
    }
    
    private lazy var imageTopStackView: UIStackView = UIStackView(arrangedSubviews: [hintImageView1, hintImageView2]).then{
        $0.axis = .horizontal
        $0.spacing = 33
        $0.distribution = .fillEqually
    }
    
    private lazy var imageBottomStackView: UIStackView = UIStackView(arrangedSubviews: [hintImageView3, hintImageView4]).then{
        $0.axis = .horizontal
        $0.spacing = 33
        $0.distribution = .fillEqually
    }
    
    private lazy var imageStackView: UIStackView = UIStackView(arrangedSubviews: [imageTopStackView, imageBottomStackView]).then{
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
    private func setButtonActions(){
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
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(170)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(220)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(220)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(90)
        }
        hintLabel.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(30)
            $0.centerX.equalTo(modalView)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(40)
            $0.trailing.equalTo(modalView.snp.trailing).inset(30)
        }
        imageStackView.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(120)
            $0.leading.equalTo(modalView.snp.leading).offset(60)
            $0.trailing.equalTo(modalView.snp.trailing).inset(60)
            $0.bottom.equalTo(modalView.snp.bottom).inset(46)
        }
    }
}
