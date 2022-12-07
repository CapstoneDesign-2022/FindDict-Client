//
//  ObjectDetection.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/29.
//

import Foundation
import UIKit
import Vision
import SnapKit
import Then

final class GameVC: ViewController {
    
    // MARK: - Properties
    private var predictedObjects: [VNRecognizedObjectObservation] = []
    private var predictedObjectLableSet: Set<String> = Set<String>() {
        didSet {
            createTargetListComponents(with: predictedObjectLableSet)
        }
    }
    
    private var theNumberOfTargetsGuessedRight: Int = 0 {
        didSet{
            if theNumberOfTargetsGuessedRight == wordTargets.count {
                let gameResultSuccessVC = GameResultSuccessVC(navigationController: self.navigationController)
                gameResultSuccessVC.modalPresentationStyle = .overCurrentContext
                self.present(gameResultSuccessVC, animated: true)
            }
        }
    }
    
    // MARK: - UI Properties
    private let logoImage: UIImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "logoImage")
    }
    
    private let targetListContainerView: UIStackView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 20
    }
    
    private lazy var wordTargets: [TargetListComponentView] = []{
        didSet{
            for wordTarget in wordTargets{
                wordTarget.setDelegate(delegate: self)
                targetListContainerView.addArrangedSubview(wordTarget)
            }
        }
    }
    
    private var cropImage: UIImage = UIImage(){
        didSet{
            requestPostWord(body: CreateWordBodyModel(english: cropImageString), image: (cropImage ?? UIImage(named: "GameOver"))!)
            
        }
    }
    
    private var cropImageString: String = ""
    
    // TODO: - private으로 만들고 setter만들기
    var image: UIImageView = UIImageView().then{
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
    }
    
    var buttonLayer: UIView = UIView()
    
    private lazy var buttons: [UIButton] = [] {
        didSet{
            for button in buttons {
                button.press{ [self] in
                    button.setImage(UIImage(named: "icon"), for: .normal)
                    button.imageView?.contentMode = .scaleAspectFit
                    button.isUserInteractionEnabled = false
                    self.disableButtons(label:button.titleLabel?.text ?? "레이블 오류")
                    self.handleGuessedRightView(label:button.titleLabel?.text ?? "레이블 오류")
                    self.presentGuessedRightWordModal(text:button.titleLabel?.text ?? "레이블 오류")
                }
                buttonLayer.addSubview(button)
                cropImage(button.titleLabel?.text ?? "",button.frame)
            }
        }
    }
    
    // TODO: 버튼 부분 아닌 곳 클릭했을 경우 x표시 나타나기
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgBeige
        setLayout()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        image.addSubview(buttonLayer)
        buttonLayer.frame = image.contentClippingRect
        putButtons(with: predictedObjects)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        resetGame()
    }
    
    // MARK: - Functions
    func increasetheNumberOfTargetsGuessedRight(){
        self.theNumberOfTargetsGuessedRight += 1
    }
    
    func setPredictedObjects(predictedObjects: [VNRecognizedObjectObservation]){
        self.predictedObjects = predictedObjects
    }
    
    func setPredictedObjectLableSet(predictedObjectLableSet: Set<String>){
        self.predictedObjectLableSet = predictedObjectLableSet
    }
    
    private func putButtons(with predictions: [VNRecognizedObjectObservation]) {
        var createdButtons: [UIButton]=[]
        for prediction in predictions {
            createdButtons.append(createButton(prediction: prediction))
            
        }
        buttons = createdButtons
    }
    
    private func createTargetListComponents(with predictions: Set<String>){
        var createdTargets: [TargetListComponentView]=[]
        for prediction in predictions {
            let component = TargetListComponentView()
            component.setData(korean: wordDictionary[prediction] ?? "사전 매칭 오류", english: prediction)
            createdTargets.append(component)
            
        }
        wordTargets = createdTargets
    }
    
    private func createButton(prediction: VNRecognizedObjectObservation)-> UIButton {
        let buttonTitle: String? = prediction.label
        let color: UIColor = labelColor(with: buttonTitle ?? "N/A")
        
        let scale = CGAffineTransform.identity.scaledBy(x: buttonLayer.bounds.width, y: buttonLayer.bounds.height)
        
        let bgRect = prediction.boundingBox.applying(scale)
        
        let button = UIButton(type: .custom).then {
            $0.frame = bgRect
            $0.layer.borderColor = color.cgColor
            $0.backgroundColor = .systemBlue
            $0.layer.borderWidth = 4
            $0.backgroundColor = UIColor.clear
            $0.setTitle(buttonTitle, for: .normal)
        }
        
        return button
    }
    
    // TODO: - 버튼 위치 잘 잡고 나면 삭제할 프로퍼티
    private var colors: [String : UIColor] = [:]
    private func labelColor(with label: String) -> UIColor {
        if let color = colors[label] {
            return color
        } else {
            let color = UIColor(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 0.8)
            colors[label] = color
            return color
        }
    }
    
    private func disableButtons(label: String){
        for button in buttons{
            if button.titleLabel?.text == label{
                button.isUserInteractionEnabled = false
            }
        }
    }
    
    private func handleGuessedRightView(label: String){
        for wordTarget in wordTargets{
            if wordTarget.getTargetLabel() == label {
                wordTarget.handleGussedRightView()
            }
        }
    }
    
    private func presentGuessedRightWordModal(text: String){
        let guessedRightWordVC = GuessedRightWordVC()
        guessedRightWordVC.setEnglishText(text: text)
        guessedRightWordVC.modalPresentationStyle = .overCurrentContext
        guessedRightWordVC.presentingVC = self
        self.present(guessedRightWordVC, animated: true)
    }
    
    
    func resizeImage(image: UIImage, size: CGSize, x: CGFloat, y: CGFloat) -> CGImage {
        UIGraphicsBeginImageContext(size)
        image.draw(in:CGRect(x: x, y: y, width: size.width, height:size.height))
        let renderImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let resultImage = renderImage?.cgImage else {
            print("image resizing error")
            return UIImage().cgImage!
        }
        return resultImage
    }
    
    private func cropImage(_ title: String, _ cropRect: CGRect){
        let newImage = resizeImage(image: image.image!, size: buttonLayer.bounds.size, x: buttonLayer.bounds.origin.x, y: buttonLayer.bounds.origin.y)
        guard let imageRef = newImage.cropping(to: cropRect) else { return  };
        let newUIImage = UIImage(cgImage: imageRef, scale: 1, orientation: self.image.image!.imageOrientation)
        
        cropImageString = title
        cropImage = newUIImage
        
    }
    
    private func resetGame(){
        for button in buttons {
            button.removeFromSuperview()
        }
        targetListContainerView.removeAllArrangedSubviews()
        theNumberOfTargetsGuessedRight = 0
    }
}

// MARK: - DictionaryCardDelegate
extension GameVC: TargetComponentViewDelegate {
    func hintButtonClicked(korean: String) {
        let hintModalVC = HintModalVC()
        hintModalVC.setKoreanText(korean: korean)
        hintModalVC.modalPresentationStyle = .overCurrentContext
        self.present(hintModalVC, animated: true)
    }
}

// MARK: - UI
extension GameVC {
    private func setLayout() {
        view.addSubViews([logoImage, targetListContainerView, image])
        logoImage.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(80)
        }
        
        targetListContainerView.snp.makeConstraints{
            $0.top.equalTo(logoImage.snp.bottom).offset(40)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
        
        image.snp.makeConstraints{
            $0.top.equalTo(targetListContainerView.snp.bottom).offset(30)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
    }
}

// MARK: - Network
extension GameVC {
    private func requestPostWord(body: CreateWordBodyModel, image: UIImage) {
        WordAPI.shared.postWord(body: body, image: image) {
            networkResult in
            switch networkResult {
            case .success(let response):
                if let res = response as? CreateWordResponseModel {
                    print(res)
                }
            default:
                self.makeAlert(title: MessageType.networkError.message)
            }
        }
    }
}
