//
//  DictionaryCard.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/01.
//

import UIKit
import Then
import SnapKit

protocol DictionaryCardDelegate: AnyObject {
    func wordDetailViewButtonClicked(index: Int)
}

final class DictionaryCard: UIView {
    
    // MARK: - Properties
    private var cellRowIndex: Int = 0
    private var delegate: DictionaryCardDelegate?
    private let englishWordLabel: UILabel = UILabel().then{
        $0.textColor = .black
        $0.text = "영어단어"
        $0.font = .findDictB1R28
    }

    private let pictureButton: UIButton = UIButton().then{
        $0.setTitle("사진 확인하기", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.backgroundColor = .fdYellow
        $0.layer.cornerRadius = 10
        $0.addShadow(location: .bottom)
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
        self.backgroundColor = .fdLightYellow
        self.layer.cornerRadius = 10.0
        self.addShadow(location: .bottom)
    }
    
    private func setButtonActions(){
        pictureButton.press {
            self.delegate?.wordDetailViewButtonClicked(index: self.cellRowIndex)
        }
    }
    
    func setData(english: String, cellRowIndex: Int){
        self.englishWordLabel.text = english
        self.cellRowIndex = cellRowIndex
    }
    
    func setDelegate(delegate: DictionaryCardDelegate){
        self.delegate = delegate
    }
}


// MARK: - UI
extension DictionaryCard {
    private func setLayout(){
        self.addSubViews([englishWordLabel, pictureButton])
        
        englishWordLabel.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(27)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        
        pictureButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-36)
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(16)
            $0.height.equalTo(53)
            $0.width.equalTo(149)
        }
    }
}
