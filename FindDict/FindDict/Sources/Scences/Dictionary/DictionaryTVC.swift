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
    private let TVCView = DictionaryCard()
    
    // MARK: Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        self.backgroundColor = .bgBeige
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI
extension DictionaryTVC {
    func setLayout(){
        self.addSubViews([TVCView])
        
        TVCView.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(10)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
            $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(0)
            $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(0)
        }
    }
}
