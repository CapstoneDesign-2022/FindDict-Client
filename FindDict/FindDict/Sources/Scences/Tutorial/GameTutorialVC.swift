//
//  GameTutorialVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit
import SnapKit
import Then

class GameTutorialVC: UIViewController{
    
    // MARK: - Properties
    var dataSource: [GameTutorialCVCModel] = GameTutorialCVCModel.sampleData
    
    private lazy var gameTutorialCV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    
    private let CVFlowLayout = UICollectionViewFlowLayout()
    
    private var originalDataSourceCount: Int {
        dataSource.count
    }
    
    private let homeButton = UIButton().then{
        $0.setImage(UIImage(named: "homeImage"),for: .normal)
    }
    
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCV()
        setButtonActions()
        view.backgroundColor = .bgYellow
    }
    
    // MARK: - Functions
    func setButtonActions() {
        homeButton.press{
            let mainView = mainVC()
            self.navigationController?.pushViewController(mainView, animated: true)
        }
    }
    
    private func setCV() {
        gameTutorialCV.delegate = self
        gameTutorialCV.dataSource = self
        
        gameTutorialCV.register(GameTutorialCVC.self, forCellWithReuseIdentifier: "GameTutorialCVC")
        
        gameTutorialCV.showsHorizontalScrollIndicator = false
        
        gameTutorialCV.isPagingEnabled = true
        
        CVFlowLayout.scrollDirection = .horizontal
    }
    
}


// MARK: - UI
extension GameTutorialVC {
    private func setLayout() {
        view.addSubViews([gameTutorialCV, homeButton])
        
        gameTutorialCV.snp.makeConstraints{
            $0.center.top.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        homeButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.width.height.equalTo(72)
        }
    }
}



// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension GameTutorialVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let beginOffset = gameTutorialCV.frame.width * CGFloat(originalDataSourceCount)
        let endOffset = gameTutorialCV.frame.width * CGFloat(originalDataSourceCount * 2 - 1)
        
        if scrollView.contentOffset.x < beginOffset && velocity.x < .zero {
            scrollToEnd = true
        } else if scrollView.contentOffset.x > endOffset && velocity.x > .zero {
            scrollToBegin = true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameTutorialCVC", for: indexPath)
        if let cell = cell as? GameTutorialCVC {
            cell.setData(dataSource[indexPath.row], index:indexPath.row%6+1)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameTutorialVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: UIScreen.main.bounds.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
