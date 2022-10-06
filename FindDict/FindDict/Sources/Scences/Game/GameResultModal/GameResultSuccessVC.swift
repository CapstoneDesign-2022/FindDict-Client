//
//  GameResultSuccessVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit
import Then
import SnapKit

class GameResultSuccessVC: ModalBaseVC {
    
    // MARK: - UI
    func setUI(){
        resultImage.image = UIImage(named: "successImage")
        resultTitleLabel.text = "Game Clear"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
}
