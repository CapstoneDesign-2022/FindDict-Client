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
        $0.backgroundColor = .white
//        $0.font = .findDictH3B16
    }
    
    private let tutorialImage = UIImageView()
    
//    private let tutorialTitleView = UIView().then{
//        //TODO: merge 후 backgroundColor 수정
//        $0.backgroundColor = UIColor.buttonYellow
////        $0.width = 304
////        $0.height = 85
////        $0.cornerRadius = 10
////        $0.layer.cornerRadius(10)
//
//    }
    
    private let tutorialTitleLabel = UILabel()
//        .then{
////        $0.font = .findDictH1B30
//    }
    
    private let tutorialTextLabel = UILabel()
//        .then{
////        $0.font = .findDictH2B18
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Functions
    func setData(_ cellData: GameTutorialCVCModel, index: Int){
        pageButton.setTitle(" \(index) / 6", for: .normal)
        tutorialImage.image = cellData.tutorialImage
        tutorialTitleLabel.text = cellData.tutorialTitle
        tutorialTextLabel.text = cellData.tutorialText
    }
}

// MARK: -UI
extension GameTutorialCVC {
    private func setLayout() {
        self.addSubViews([tutorialTextLabel])
        
//        tutorialTitleView.addSubview([tutorialTitleLabel])
//
//        tutorialTitleLabel.snp.makeConstraints{
//            $0.centerX.equalTo(self.safeAreaLayoutGuide)
//        }
        
//        tutorialTitleView.snp.makeConstraints{
//            $0.centerX.equalTo(self.safeAreaLayoutGuide)
//            $0.top.equalTo(self.safeAreaLayoutGuide).inset(59)
//        }
// 
//        tutorialImage.snp.makeConstraints{
//            $0.centerX.equalTo(self.safeAreaLayoutGuide)
//            $0.top.equalTo(tutorialTitleView).inset(27)
//        }
        
        //TODO: pageButton 넣을까 말까
        //TODO: home icon 깜빡했다
        
        tutorialTextLabel.snp.makeConstraints{
            $0.top.equalTo(self.safeAreaLayoutGuide).inset(21)
        }
    }
}
