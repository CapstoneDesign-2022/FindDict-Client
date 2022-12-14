//
//  DictionaryDetailVC.swift
//  FindDict
//
//  Created by kyung lin kim on 2022/11/06.
//

import UIKit
import SnapKit
import Then
import AVFAudio

final class DictionaryDetailVC: UIViewController{
    
    // MARK: - Properties
    private var worldLabelText: String = "" {
        didSet{
            wordLabel.text = worldLabelText
            requestGetWordDetail(word: worldLabelText)
        }
    }
    
    private let synthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    private var dataSource : [String] = ["https://finddict.s3.ap-northeast-2.amazonaws.com/test/1668622382989_launchScreen.png"]{
        didSet{
            self.increasedDataSource =  dataSource + dataSource + dataSource
        }
    }
    
    private lazy var increasedDataSource: [String] = {
        dataSource + dataSource + dataSource
    }()
    
    private lazy var dictionaryDetailCV: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: CVFlowLayout)
    
    private let CVFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private var originalDataSourceCount: Int {
        dataSource.count
    }
    
    private var scrollToEnd: Bool = false
    private var scrollToBegin: Bool = false
    
    // MARK: - UI Properties
    private let modalView: UIView = UIView().then{
        $0.backgroundColor = .fdLightYellow
        $0.addShadow(location: .bottom)
    }
    
    private let closeButton: UIButton = UIButton().then{
        $0.setImage(UIImage(named: "closeImage"), for: .normal)
    }
    
    private let wordLabel: UILabel = UILabel().then{
        $0.textColor = .black
        $0.font = .findDictH4M35
        $0.backgroundColor = .fdDarkYellow
        $0.textAlignment = .center
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    private let americanSpeeachButton: SpeechButton = SpeechButton().then{
        $0.setTitle("🇺🇸 미국식 발음", for: .normal)
        $0.backgroundColor = .fdDarkYellow
    }
    
    private let englishSpeeachButton: SpeechButton = SpeechButton().then{
        $0.setTitle("🇬🇧 영국식 발음", for: .normal)
        $0.backgroundColor = .fdDarkYellow
    }
    
    private let australianSpeeachButton: SpeechButton = SpeechButton().then{
        $0.setTitle("🇦🇺 호주식 발음", for: .normal)
        $0.backgroundColor = .fdDarkYellow
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [americanSpeeachButton,englishSpeeachButton,australianSpeeachButton]).then{
        $0.axis = .horizontal
        $0.spacing = 30
        $0.distribution = .fillEqually
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setCV()
        setButtonActions()
        view.backgroundColor = .bgModal
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dictionaryDetailCV.scrollToItem(at: IndexPath(item: originalDataSourceCount,section: 0),
                                        at: .centeredHorizontally,
                                        animated: false)
    }
    
    // MARK: - Functions
    private func setCV() {
        dictionaryDetailCV.do{
            $0.delegate = self
            $0.dataSource = self
            $0.register(DictionaryDetailCVC.self, forCellWithReuseIdentifier: "DictionaryDetailCVC")
            $0.showsHorizontalScrollIndicator = false
            $0.isPagingEnabled = true
        }
        
        CVFlowLayout.scrollDirection = .horizontal
    }
    
    private func printOutAmericanSpeech(){
        let utterance = AVSpeechUtterance(string: wordLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    private func printOutEnglishSpeech(){
        let utterance = AVSpeechUtterance(string: wordLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    private func printOutAustralianSpeech(){
        let utterance = AVSpeechUtterance(string: wordLabel.text!)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-AU")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    private func setButtonActions(){
        closeButton.press{
            self.dismiss(animated: true, completion: nil)
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
    
    func setWordLabelText(english: String){
        worldLabelText = english
    }
}
extension DictionaryDetailVC {
    private func requestGetWordDetail(word: String) {
        WordAPI.shared.getWordDetail(word: word) { [self] NetworkResult in
            switch NetworkResult {
            case .success(let response):
                if let res = response as? WordDetailResponseModel{
                    var urls: [String] = []
                    for res_url in res.urls {
                        urls.append(res_url.image_url)
                    }
                    self.dataSource = urls
                    self.dictionaryDetailCV.reloadData()
                }
            default:
                print(MessageType.networkError.message)
            }
        }
    }
}


// MARK: - UI
extension DictionaryDetailVC {
    private func setLayout() {
        view.addSubViews([modalView, closeButton, wordLabel, dictionaryDetailCV, buttonStackView])
        modalView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(120)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(120)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).inset(120)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(64)
            $0.height.equalTo(615)
        }
        
        closeButton.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(30)
            $0.trailing.equalTo(modalView.snp.trailing).inset(30)
        }
        
        wordLabel.snp.makeConstraints{
            $0.top.equalTo(modalView.snp.top).offset(35)
            $0.centerX.equalTo(modalView)
            $0.height.equalTo(70)
            $0.width.equalTo(300)
        }
        
        dictionaryDetailCV.snp.makeConstraints{
            $0.top.equalTo(wordLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalTo(modalView)
            $0.bottom.equalTo(modalView.snp.bottom).inset(100)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(dictionaryDetailCV.snp.bottom).offset(10)
            $0.leading.leading.equalTo(modalView.snp.leading).offset(100)
            $0.trailing.leading.equalTo(modalView.snp.trailing).inset(100)
            $0.bottom.equalTo(modalView.snp.bottom).inset(30)
        }
    }
}


// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension DictionaryDetailVC : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView,
                                   withVelocity velocity: CGPoint,
                                   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let beginOffset = dictionaryDetailCV.frame.width * CGFloat(originalDataSourceCount)
        let endOffset = dictionaryDetailCV.frame.width * CGFloat(originalDataSourceCount * 2 - 1)
        
        if scrollView.contentOffset.x < beginOffset && velocity.x < .zero {
            scrollToEnd = true
        } else if scrollView.contentOffset.x > endOffset && velocity.x > .zero {
            scrollToBegin = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollToBegin {
            dictionaryDetailCV.scrollToItem(at: IndexPath(item: originalDataSourceCount, section: .zero),
                                            at: .centeredHorizontally,
                                            animated: false)
            scrollToBegin.toggle()
            return
        }
        
        if scrollToEnd {
            dictionaryDetailCV.scrollToItem(at: IndexPath(item: originalDataSourceCount * 2 - 1, section: .zero),
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DictionaryDetailCVC", for: indexPath)
        if let cell = cell as? DictionaryDetailCVC {
            cell.setData(increasedDataSource[indexPath.row],index:indexPath.row%3+1)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension DictionaryDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
}
