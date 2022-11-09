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
    lazy var pageButton = UIButton().then{
        $0.layer.cornerRadius = 12
    }
    
    private let tutorialImage = UIImageView().then{
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    private let tutorialTitleView = UIView().then{
        //TODO: merge 후 backgroundColor 수정
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 10
    }
    
    private let tutorialTitleLabel = UILabel().then{
        $0.font = .findDictH1B30
    }
    
    private let tutorialTextLabel = UILabel().then{
        $0.font = .findDictH2B18
    }
    
    private let homeButton = UIButton().then{
        $0.setImage(UIImage(named: "homeImage"),for: .normal)
    }
    
    //MARK: - Functions
    func setData(_ cellData: GameTutorialCVCModel, index: Int){
        pageButton.setTitle(" \(index) / 6", for: .normal)
        tutorialImage.image = cellData.tutorialImage
        tutorialTitleLabel.text = cellData.tutorialTitle
        tutorialTextLabel.text = cellData.tutorialText
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

    // MARK: - UI
    extension GameTutorialCVC {
        private func setLayout() {
            self.addSubViews([tutorialTitleView, tutorialTextLabel, tutorialImage, homeButton])
            tutorialTitleView.addSubViews([tutorialTitleLabel])
            
            tutorialTitleView.snp.makeConstraints{
                $0.centerX.equalTo(self.safeAreaLayoutGuide)
                $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(19)
                $0.height.equalTo(50)
                $0.width.equalTo(304)
            }
            
            tutorialTitleLabel.snp.makeConstraints{
                $0.centerX.equalTo(self.safeAreaLayoutGuide)
                $0.centerY.equalTo(tutorialTitleView)
            }
            
            tutorialTextLabel.snp.makeConstraints{
                $0.centerX.equalTo(self.safeAreaLayoutGuide)
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(19)
            }
            
            tutorialImage.snp.makeConstraints{
                $0.centerX.equalTo(self.safeAreaLayoutGuide)
                $0.top.equalTo(tutorialTitleView.snp.bottom).offset(40)
                $0.bottom.equalTo(tutorialTextLabel.snp.top).inset(-21)
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).inset(203)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(203)
            }
            
            homeButton.snp.makeConstraints{
                $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
                $0.trailing.equalTo(self.safeAreaLayoutGuide).inset(40)
                $0.width.height.equalTo(50)
            }
        }
    }
