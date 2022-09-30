//
//  DictionaryVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/09/30.
//

import UIKit
import SnapKit
import Then

class DictionaryVC: UIViewController {
    
    // MARK: - Properties
    private let titleView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    
    private let titleLabel = UILabel().then{
        $0.textColor = .black
        $0.text = "단어장"
        $0.font = .findDictH5R48
    }
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        view.backgroundColor = .bgBeige
    }

}

extension DictionaryVC {
    private func setLayout() {
        view.addSubViews([titleView])
        titleView.addSubViews([titleLabel])
        
        titleView.snp.makeConstraints{
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(52)
            $0.width.equalTo(601)
            $0.height.equalTo(119)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerX.equalTo(titleView)
            $0.centerY.equalTo(titleView)
        }
    }
}
