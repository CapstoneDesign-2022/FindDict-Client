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
    
    
    private let englishLabel = UILabel()
    private var englishText:String = ""{
        didSet{
            englishLabel.text = englishText
            printOutSpeech()
        }
    }
    private let synthesizer = AVSpeechSynthesizer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}
