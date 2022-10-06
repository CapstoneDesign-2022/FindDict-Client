//
//  GameResultFailVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//
import UIKit
import Then
import SnapKit

class GameResultFailVC: ModalBaseVC {
    
    // MARK: - UI
    func setUI(){
        resultImage.image = UIImage(named: "failureImage")?.withAlignmentRectInsets(UIEdgeInsets(top: -40, left: 0, bottom: 0, right: -65))
        resultTitleLabel.text = "하트를 모두 사용했어요"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}
