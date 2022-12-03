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
    private let englishLabel: UILabel = UILabel().then {
        $0.font = .findDictH4R35
        $0.textColor = .black
    }
    
    private var englishText: String = "" {
        didSet{
            englishLabel.text = englishText
            printOutAmericanSpeech()
        }
    }
    
    private let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    private let modalView: UIView = UIView().then{
        $0.backgroundColor = .bgBeige
        $0.layer.shadowRadius = 4
        $0.layer.shadowOffset = CGSize(width: 0, height: 4)
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
    }
    
    private let closeButton: UIButton = UIButton().then{
        $0.setImage(UIImage(named: "closeImage"), for: .normal)
    }
    
    private let americanSpeeachButton: SpeechButton = SpeechButton().then{
        $0.setTitle("🇺🇸 미국식 발음으로 듣기", for: .normal)
    }
    private let englishSpeeachButton: SpeechButton = SpeechButton().then{
        $0.setTitle("🇬🇧 영국식 발음으로 듣기", for: .normal)
    }
    private let australianSpeeachButton: SpeechButton = SpeechButton().then{
        $0.setTitle("🇦🇺 호주식 발음으로 듣기", for: .normal)
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [americanSpeeachButton,englishSpeeachButton,australianSpeeachButton]).then{
        $0.axis = .vertical
        $0.spacing = 15
        $0.distribution = .fillEqually
    }
    
    var presentingVC: UIViewController?
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgModal
        setLayout()
        setButtonActions()
    }
    
    // MARK: - Functions
    func setEnglishText(text: String){
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
        view.addSubViews([modalView, englishLabel, closeButton, buttonStackView])
        
        modalView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(236)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(223)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(223)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(92)
        }
        
        englishLabel.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(40)
            $0.centerX.equalTo(modalView)
            $0.height.equalTo(50)
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(16)
            $0.trailing.equalTo(modalView.snp.trailing).inset(20)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(englishLabel.snp.bottom).offset(30)
            $0.leading.equalTo(modalView.snp.leading).offset(30)
            $0.trailing.equalTo(modalView.snp.trailing).inset(30)
            $0.bottom.equalTo(modalView.snp.bottom).inset(30)
        }
    }
}
