//
//  GameResultFailVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//
import UIKit
import Then
import SnapKit

final class GameResultFailVC: ModalBaseVC {
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    // MARK: - UI
    private func setUI(){
        resultImage.image = UIImage(named: "failureImage")?.withAlignmentRectInsets(UIEdgeInsets(top: -40, left: 0, bottom: 0, right: -65))
        
        resultTitleLabel.then{
            $0.text = "하트를 모두 사용했어요"
            $0.textColor = .white
            $0.backgroundColor = .fdBrown
        }
    }
}
