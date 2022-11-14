//
//  DictionaryCard.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/01.
//

import UIKit
import Then
import SnapKit

class DictionaryCard: UIView {
    
    // MARK: - Properties
    private var dictionaryDetailData: [WordDetailResponseModel.ImageURL]?
    let englishWordLabel = UILabel().then{
        $0.textColor = .black
        $0.text = "영어단어"
        $0.font = .findDictH4R28
    }
    let koreanWordLabel = UILabel().then{
        $0.textColor = .black
        $0.text = "한글단어"
        $0.font = .findDictH4R28
    }
    lazy var wordStackView = UIStackView(arrangedSubviews: [englishWordLabel, koreanWordLabel]).then{
        $0.axis = .horizontal
        $0.spacing = 83
        $0.distribution = .fillEqually
    }
    private let pictureButton = UIButton().then{
        $0.setTitle("사진 확인하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .buttonApricot
        $0.layer.cornerRadius = 10
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowRadius = 5
        $0.layer.shadowOpacity = 0.25
    }
    
    // MARK: Initializaiton
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setLayout()
        setUI()
        setButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Funtions
    private func setUI() {
        self.backgroundColor = .dictionaryGray
        self.layer.cornerRadius = 10.0
    }
    
    func setButtonActions(){
        pictureButton.press{
//            self.navigationController?.popToRootViewController(animated: false)
            self.requestGetWordDetail()
        }
    }
}

extension DictionaryCard {
    private func requestGetWordDetail() {
        WordAPI.shared.getWordDetail(word: "apple") { NetworkResult in
            switch NetworkResult {
            case .success(let response):
                if let res = response as?
                    WordDetailResponseModel {
                    print(">>>>>>res", res)
                }
            default:
                print(MessageType.networkError.message)
            }
        
        }
    }
}

// MARK: - UI
extension DictionaryCard {
    func setLayout(){
        self.addSubViews([wordStackView, pictureButton])
        
        wordStackView.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(27)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
            $0.height.equalTo(40)
            $0.width.equalTo(480)
        }
        
        pictureButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-36)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            $0.height.equalTo(53)
            $0.width.equalTo(149)
        }
    }
}
