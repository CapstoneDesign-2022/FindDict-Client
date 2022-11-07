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
    lazy var pageButton = UIButton().then{
        $0.layer.cornerRadius = 12
        $0.setTitleColor(.black, for: .normal)
    }
    private let wordImageView = UIImageView()
        
        
    //MARK: - Functions
    func setData(_ cellData: UIImage, index: Int){
            pageButton.setTitle(" \(index)", for: .normal)
            wordImageView.image = cellData
        }
        
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
            self.addSubViews([pageButton, wordImageView])

            wordImageView.snp.makeConstraints{
                $0.centerY.equalTo(self.safeAreaLayoutGuide)
                $0.centerX.equalTo(self.safeAreaLayoutGuide)
            }
            pageButton.snp.makeConstraints{
                $0.top.equalTo(wordImageView.snp.bottom).offset(10)
                $0.centerX.equalTo(wordImageView)
                $0.height.equalTo(10)
            }
        }
    }

