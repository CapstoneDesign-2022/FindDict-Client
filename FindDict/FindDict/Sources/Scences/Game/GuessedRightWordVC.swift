//
//  GuessedRightWordVC.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/04.
//

import UIKit
import AVFoundation
import SnapKit
import Then

class GuessedRightWordVC: UIViewController {
    
    // MARK: - Properties
    private let englishLabel = UILabel().then{
        $0.font = .findDictH4R35
        $0.textColor = .black
    }
    private var englishText:String = ""{
        didSet{
            englishLabel.text = englishText
            printOutSpeech()
        }
    }
    private let synthesizer = AVSpeechSynthesizer()
    
    private let modalView = UIView().then{
        $0.backgroundColor = .bgBeige
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    
    private let closeButton = UIButton().then{
        $0.setImage(UIImage(named: "closeImage"), for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgModal
        setLayout()
        setButtonActions()
    }
    
    func setEnglishText(text:String){
        englishText = text
    }
    
    private func printOutSpeech(){
        let utterance = AVSpeechUtterance(string: englishText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    private func setButtonActions(){
        closeButton.press{
            self.dismiss(animated: true, completion: nil)
        }
    }
}


// MARK: - UI
extension GuessedRightWordVC {
    private func setLayout() {
        view.addSubViews([modalView, englishLabel, closeButton])
        
        modalView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(236)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(223)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(223)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(92)
        }
        englishLabel.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(40)
            $0.centerX.equalTo(modalView)
        }
        closeButton.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(16)
            $0.trailing.equalTo(modalView.snp.trailing).inset(20)
      
        }
        
    }
}
