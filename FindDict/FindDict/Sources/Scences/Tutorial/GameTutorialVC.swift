//
//  GameTutorialVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit
import SnapKit
import Then

final class GameTutorialVC: UIViewController{
    
    // MARK: - Properties
    private var dataSource: [GameTutorialCVCModel] = GameTutorialCVCModel.sampleData
    
    private let naviView = DefaultNavigationBar(isHomeButtonIncluded: false).then {
        $0.setTitleLabel(title: "Game Tutorial")
    }
    
    private lazy var gameTutorialCV: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    
    private let CVFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var originalDataSourceCount: Int {
        dataSource.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCV()
        view.backgroundColor = .fdLightYellow
        self.navigationController?.navigationBar.isHidden = true
        naviView.setDelegate(delegate: self)
    }
    
    // MARK: - Functions
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
        view.addSubViews([naviView, gameTutorialCV])
        
        naviView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        gameTutorialCV.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom)
            $0.bottom.leading.trailing.equalTo(view.safeAreaLayoutGuide)
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

// MARK: - DefaultNavigationBarDelegate
extension GameTutorialVC: DefaultNavigationBarDelegate {
    func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func homeButtonClicked(){
        self.navigationController?.popToRootViewController(animated: false)
    }
}
