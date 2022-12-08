//
//  GameTutorialCVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit
import SnapKit
import Then

class GameTutorialCVC: UICollectionViewCell {
    
    // MARK: - Properties
    private let tutorialImage: UIImageView = UIImageView().then{
        $0.layer.cornerRadius = 43
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    private lazy var contentsStackView: UIStackView = UIStackView(arrangedSubviews: [tutorialTitleLabel, tutorialTextLabel]).then{
        $0.axis = .vertical
        $0.spacing = 30
    }
    
    private let tutorialTitleLabel: UILabel = UILabel().then{
        $0.font = .findDictH3B36
    }
    
    private let tutorialTextLabel: UILabel = UILabel().then{
        $0.font = .findDictB3R20
        $0.lineBreakMode = .byCharWrapping
        $0.numberOfLines = 0    // 자동 줄바꿈
    }
    
    lazy var pageButton: UIButton = UIButton().then{
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .findDictB4R16
        
    }
    
    //MARK: - Functions
    func setData(_ cellData: GameTutorialCVCModel, index: Int){
        pageButton.setTitle("   \(index) / 6  > ", for: .normal)
        tutorialImage.image = cellData.tutorialImage
        tutorialTitleLabel.text = cellData.tutorialTitle
        tutorialTextLabel.text = cellData.tutorialText
    }
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        self.backgroundColor = .bgYellow
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

    // MARK: - UI
    extension GameTutorialCVC {
        private func setLayout() {
            self.addSubViews([tutorialImage, contentsStackView, pageButton])
            
            tutorialImage.snp.makeConstraints{
                $0.top.equalToSuperview().offset(150)
                $0.left.equalToSuperview().offset(30)
                $0.width.equalTo(700)
                $0.height.equalTo(500)
            }
            
            contentsStackView.snp.makeConstraints{
                $0.top.equalToSuperview().offset(180)
                $0.left.equalTo(tutorialImage.snp.right).offset(50)
                $0.right.equalToSuperview().inset(30)
            }

            
            pageButton.snp.makeConstraints{
                $0.height.equalTo(40)
                $0.width.equalTo(80)
                $0.bottom.equalToSuperview().offset(-186)
                $0.right.equalToSuperview().inset(48)
            }
        }
    }
