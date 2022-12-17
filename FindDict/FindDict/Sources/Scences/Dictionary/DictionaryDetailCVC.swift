//
//  DictionaryDetailCVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/06.
//

import UIKit
import SnapKit
import Then

final class DictionaryDetailCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let wordImageView: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        self.backgroundColor = .fdLightYellow
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: String, index: Int){
        wordImageView.load(cellData)
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

