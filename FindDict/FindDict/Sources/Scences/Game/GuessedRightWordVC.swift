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
            printOutAmericanSpeech()
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
    
    private let americanSpeeachButton = UIButton().then{
        $0.setTitle("🗣🇺🇸", for: .normal)
    }
    private let englishSpeeachButton = UIButton().then{
        $0.setTitle("🗣🇬🇧", for: .normal)
    }
    private let australianSpeeachButton = UIButton().then{
        $0.setTitle("🗣🇦🇺", for: .normal)
    }
    
    private lazy var buttonStackView = UIStackView(arrangedSubviews: [americanSpeeachButton,englishSpeeachButton,australianSpeeachButton]).then{
        $0.axis = .horizontal
        $0.spacing = 33
    }
    
    
    var presentingVC:UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgModal
        setLayout()
        setButtonActions()
    }
    
    func setEnglishText(text:String){
        englishText = text
    }
    
    private func setButtonActions(){
        closeButton.press{
            guard let pvc = self.presentingVC as? GameVC else {return}
            pvc.dismiss(animated: true){
                pvc.increasetheNumberOfTargetsGuessedRight()
            }
        }
        americanSpeeachButton.press{
            self.printOutAmericanSpeech()
        }
        englishSpeeachButton.press{
            self.printOutEnglishSpeech()
        }
        australianSpeeachButton.press{
            self.printOutAustralianSpeech()
        }
    }
    
    private func printOutAmericanSpeech(){
        let utterance = AVSpeechUtterance(string: englishText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        //        utterance.voice?.gender = .female
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    private func printOutEnglishSpeech(){
        let utterance = AVSpeechUtterance(string: englishText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    private func printOutAustralianSpeech(){
        let utterance = AVSpeechUtterance(string: englishText)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
}


// MARK: - UI
extension GuessedRightWordVC {
    private func setLayout() {
        view.addSubViews([modalView, englishLabel, closeButton,buttonStackView])
        
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
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(englishLabel.snp.bottom).offset(30)
            $0.centerX.equalTo(modalView)
        }
        
    }
}
