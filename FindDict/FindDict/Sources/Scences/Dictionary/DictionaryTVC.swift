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
    let dictionaryCard: DictionaryCard = DictionaryCard()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        self.backgroundColor = .bgBeige
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    func setData(_ cellData: String, cellRowIndex: Int) {
        dictionaryCard.setData(english: cellData, cellRowIndex: cellRowIndex)
    }
}

// MARK: - UI
extension DictionaryTVC {
    private func setLayout(){
        self.addSubViews([dictionaryCard])
        
        dictionaryCard.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(0)
        }
    }
}
