//
//  GameResultSuccessVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/10/06.
//

import UIKit
import Then
import SnapKit
import AVFoundation

class GameResultSuccessVC: ModalBaseVC {
    
    // MARK: - Properties
    var player: AVAudioPlayer?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        playSound()
    }
    
    // MARK: - UI
    func setUI(){
        resultImage.image = UIImage(named: "successImage")
        resultTitleLabel.text = "Game Clear"
    }
    
    func playSound(){
        guard let url = Bundle.main.url(forResource: "GameClear", withExtension: "wav") else { return }
            do {
                player = try AVAudioPlayer(contentsOf: url)
                guard let player = player else { return }
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
    }
}
