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
    private lazy var increasedDataSource: [GameTutorialCVCModel] = {
        dataSource + dataSource + dataSource
    }()
    
    private lazy var gameTutorialCV = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    
    private let CVFlowLayout = UICollectionViewFlowLayout()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gameTutorialCV.scrollToItem(at: IndexPath(item: originalDataSourceCount,section: 0),
                                at: .centeredHorizontally,
                                animated: false)
    }
}

// MARK: - UI
extension GameTutorialVC {
    private func setLayout() {
        view.addSubview(gameTutorialCV)
        gameTutorialCV.snp.makeConstraints{
            $0.center.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(789)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollToBegin {
            gameTutorialCV.scrollToItem(at: IndexPath(item: originalDataSourceCount, section: .zero),
                                    at: .centeredHorizontally,
                                    animated: false)
            scrollToBegin.toggle()
            return
        }
        if scrollToEnd {
            gameTutorialCV.scrollToItem(at: IndexPath(item: originalDataSourceCount * 2 - 1, section: .zero),
                                    at: .centeredHorizontally,
                                    animated: false)
            scrollToEnd.toggle()
            return
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return increasedDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameTutorialCVC", for: indexPath)
        if let cell = cell as? GameTutorialCVC {
            cell.setData(increasedDataSource[indexPath.row],index:indexPath.row%3+1)
        }

        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension GameTutorialVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
