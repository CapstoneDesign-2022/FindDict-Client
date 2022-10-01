//
//  DictionaryTVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/01.
//

import UIKit
import SnapKit
import Then

class DictionaryTVC: UITableViewCell {
    
    // MARK: - Properties
    private let englishWordLabel = UILabel().then{
        $0.textColor = .black
        $0.text = "영어단어"
        $0.font = .findDictH4R35
    }
    private let koreanWordLabel = UILabel().then{
        $0.textColor = .black
        $0.text = "한글단어"
        $0.font = .findDictH4R35
    }
    private let pictureButton = UIButton().then{
        $0.setTitle("사진 보기", for: .normal)
        $0.backgroundColor = .buttonApricot
    }
    // 나중에 StackView로 묶기
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        self.backgroundColor = .gray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

// MARK: - UI
extension DictionaryTVC {
    func setLayout(){
        self.addSubViews([englishWordLabel, koreanWordLabel, pictureButton])
        
        englishWordLabel.snp.makeConstraints{
            $0.height.equalTo(40)
        }
        pictureButton.snp.makeConstraints{
            $0.leading.equalTo(englishWordLabel.snp.trailing).offset(10)
            $0.height.equalTo(53)
        }
    }
}
