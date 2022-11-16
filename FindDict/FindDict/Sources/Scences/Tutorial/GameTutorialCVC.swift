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
    private let tutorialTitleView: UIView = UIView().then{
        //TODO: merge 후 backgroundColor 수정
        $0.backgroundColor = .buttonOrange
        $0.layer.cornerRadius = 10
    }
    
    private let tutorialTitleLabel: UILabel = UILabel().then{
        $0.font = .findDictH1B30
    }
    
    lazy var pageButton: UIButton = UIButton().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .findDictH4R28
    }
    
    private let tutorialImage: UIImageView = UIImageView().then{
        $0.layer.cornerRadius = 43
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    private let tutorialTextLabel: UILabel = UILabel().then{
        $0.font = .findDictH2B18
        $0.numberOfLines = 0    // 자동 줄바꿈
    }
    
    //MARK: - Functions
    func setData(_ cellData: GameTutorialCVCModel, index: Int){
        pageButton.setTitle(" \(index) / 6  > ", for: .normal)
        tutorialImage.image = cellData.tutorialImage
        tutorialTitleLabel.text = cellData.tutorialTitle
        tutorialTextLabel.text = cellData.tutorialText
    }
    
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
            self.addSubViews([tutorialTitleView, tutorialImage, tutorialTextLabel, pageButton])
            tutorialTitleView.addSubViews([tutorialTitleLabel])
            
            tutorialTitleView.snp.makeConstraints{
                $0.centerX.equalTo(self.safeAreaLayoutGuide)
                $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(82)
                $0.height.equalTo(85)
                $0.width.equalTo(334)
            }
            
            tutorialTitleLabel.snp.makeConstraints{
                $0.centerX.equalTo(tutorialTitleView)
                $0.centerY.equalTo(tutorialTitleView)
            }
            
            tutorialImage.snp.makeConstraints{
                $0.top.equalTo(tutorialTitleView.snp.bottom).offset(25)
                $0.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(30)
                $0.width.equalTo(750)
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(50)
            }
            
            tutorialTextLabel.snp.makeConstraints{
                $0.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(350)
                $0.leading.equalTo(tutorialImage.snp.trailing).offset(25)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(25)
            }
            
            pageButton.snp.makeConstraints{
                $0.height.equalTo(60)
                $0.width.equalTo(126)
                $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(150)
                $0.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(40)
            }
        }
    }
