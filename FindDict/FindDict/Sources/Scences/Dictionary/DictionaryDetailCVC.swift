//
//  DictionaryDetailCVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/06.
//

import UIKit
import SnapKit
import Then

class DictionaryDetailCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let wordImageView = UIImageView()
    
    
    //MARK: - Functions
    func setData(_ cellData: String, index: Int){
        wordImageView.load(cellData)
    }
    
    // MARK: - View Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        self.backgroundColor = .modalButtonLightYellow
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - UI
extension DictionaryDetailCVC {
    private func setLayout() {
        self.addSubViews([wordImageView])
        
        wordImageView.snp.makeConstraints{
            $0.centerY.equalTo(self.safeAreaLayoutGuide)
            $0.centerX.equalTo(self.safeAreaLayoutGuide)
        }
    }
}

