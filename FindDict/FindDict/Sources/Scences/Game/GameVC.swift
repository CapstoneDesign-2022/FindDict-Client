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
    
    private let cropImageView: UIImageView = UIImageView()
    
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
            }
        }
    }
    
    // TODO: 버튼 부분 아닌 곳 클릭했을 경우 x표시 나타나기
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgBeige
        setLayout()
        for word in predictedObjectLableSet{
            requestPostWord(body: CreateWordBodyModel(english: word), image: (cropImageView.image ?? UIImage(named: "GameOver"))!)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print(">>>>>>",image.bounds)
        image.addSubview(buttonLayer)
        buttonLayer.frame = image.bounds
        putButtons(with: predictedObjects)
//        image.setNeedsDisplay()
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
    
    func putButtons(with predictions: [VNRecognizedObjectObservation]) {
        var createdButtons:[UIButton]=[]
        for prediction in predictions {
            createdButtons.append(createButton(prediction: prediction))
        }
        buttons = createdButtons
    }
    
    private func createTargetListComponents(with predictions: Set<String>){
        var createdTargets:[TargetListComponentView]=[]
        for prediction in predictions {
            let component = TargetListComponentView()
            component.setData(korean: wordDictionary[prediction] ?? "사전 매칭 오류", english: prediction)
            createdTargets.append(component)
            
        }
        wordTargets = createdTargets
    }
    
    /// 인식된 객체마다 이에 맞는 버튼을 생성합니다.
    private func createButton(prediction: VNRecognizedObjectObservation)-> UIButton {
        let buttonTitle: String? = prediction.label
        let color: UIColor = labelColor(with: buttonTitle ?? "N/A")
        //        print(prediction.boundingBox)
        //        print(prediction.label)
        //        print("image.frame",image.frame)
        //        print("image.bounds",image.bounds)
        //        let scale = CGAffineTransform.identity.scaledBy(x: image.bounds.width, y: image.bounds.height)
        //        print("scale",scale)
        //        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        //        print(prediction.boundingBox.origin.x,prediction.boundingBox.origin.y, prediction.boundingBox.width,prediction.boundingBox.height)
        //        let buttonRect = prediction.boundingBox.applying(scale)
        //        print(buttonRect)
        //        print(labelString,bgRect)
        //                let buttonRect = CGRect(x: prediction.boundingBox.origin.x, y: prediction.boundingBox.origin.y, width: prediction.boundingBox.width, height: prediction.boundingBox.height)
        let scale = CGAffineTransform.identity.scaledBy(x: buttonLayer.bounds.width, y: buttonLayer.bounds.height)
        //        print("scale",scale)
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        let bgRect = prediction.boundingBox.applying(transform).applying(scale)
        //        print(bgRect)
        let x = (prediction.boundingBox.origin.x - prediction.boundingBox.size.width/2)*image.frame.size.width
        let y = (prediction.boundingBox.origin.y - prediction.boundingBox.size.height/2)*image.frame.size.height
        let width = prediction.boundingBox.size.width * image.frame.size.width
        let height = prediction.boundingBox.size.height * image.frame.size.height
        //        print(x,y,width,height)
        cropImage(origin: CGPoint(x: x, y: y),size: CGSize(width: width, height: height))
        
        //TODO: 스케일 맞추기
        //        let buttonRect = CGRect(x: prediction.boundingBox.origin.x*500, y: prediction.boundingBox.origin.y*500, width: prediction.boundingBox.width*500, height: prediction.boundingBox.height*500)
        let button = UIButton(type: .custom)
        button.frame = bgRect
        button.layer.borderColor = color.cgColor
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 4
        button.backgroundColor = UIColor.clear
        button.setTitle(buttonTitle, for: .normal)
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
    
    private func cropImage(origin: CGPoint, size: CGSize){
        //        print("origin",origin)
        //        print("size",size)
        let cropRect = CGRect(origin: origin, size: size)
        guard let imageRef = image.image?.cgImage?.cropping(to: cropRect) else { return  };
        let newImage = UIImage(cgImage: imageRef, scale: image.image!.scale, orientation: image.image!.imageOrientation)
        cropImageView.image = newImage
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
        view.addSubViews([logoImage, targetListContainerView, image, cropImageView])
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
        cropImageView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
            //            $0.width.equalTo(100)
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
