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


class GameVC:ViewController {
    
    // MARK: - Vision Properties
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    var isInferencing = false
    let semaphore = DispatchSemaphore(value: 1)
    private let objectDectectionModel = yolov5m() //yolov7()
    // TODO: - private으로 바꾸고 setter 만들기
    var pixelBuffer:CVPixelBuffer? = nil {
        didSet{
            setUpModel()
            handleImage(pixelBuffer: pixelBuffer)
        }
    }
    
    private var predictedObjects: [VNRecognizedObjectObservation] = [] {
        didSet {
            putButtons(with: predictedObjects)
            var predectedObjectLabels = Set<String>()
            for predictedObject in predictedObjects {
                predectedObjectLabels.insert(predictedObject.label ?? "레이블오류")
            }
            predictedObjectLableSet = predectedObjectLabels
        }
    }
    
    private var predictedObjectLableSet = Set<String>() {
        didSet {
            createTargetListComponents(with: predictedObjectLableSet)
        }
    }
    
    // TODO: - 버튼 위치 잘 잡고 나면 삭제할 프로퍼티
    private var colors: [String: UIColor] = [:]
    private var theNumberOfTargetsGuessedRight = 0 {
        didSet{
            if theNumberOfTargetsGuessedRight == wordTargets.count {
                let gameResultSuccessVC = GameResultSuccessVC(navigationController: self.navigationController)
//                gameResultSuccessVC.modalTransitionStyle = .crossDissolve
//                gameResultSuccessVC.modalPresentationStyle = .overFullScreen
                gameResultSuccessVC.modalPresentationStyle = .overCurrentContext
                self.present(gameResultSuccessVC, animated: true)
            }
        }
    }
    
    // MARK: - UI Properties
    private let logoImage = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "logoImage")
    }
    
    private let targetListContainerView = UIStackView().then{
        $0.axis = .horizontal
        $0.spacing = 20
    }
    
    private lazy var wordTargets: [TargetListComponentView] = []{
        didSet{
            for wordTarget in wordTargets{
                targetListContainerView.addArrangedSubview(wordTarget)
            }
        }
    }
    
    // TODO: - private으로 만들고 setter만들기
    var image = UIImageView().then{
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
    }
    
    private var buttonLayer = UIView()
    
    private lazy var buttons: [UIButton] = [] {
        didSet{
            for button in buttons {
                button.press{ [self] in 
                    button.setImage(UIImage(named: "icon"), for: .normal)
                    button.imageView?.contentMode = .scaleAspectFit
                    button.isUserInteractionEnabled = false
                    self.disableButtons(label:button.titleLabel?.text ?? "레이블 오류")
                    self.handleGuessedRightView(label:button.titleLabel?.text ?? "레이블 오류")
                    self.theNumberOfTargetsGuessedRight += 1
                }
                buttonLayer.addSubview(button)
            }
        }
    }
    
    // TODO: 모든 객체 리스트 비활성화됐을 경우 게임 종료
    // TODO: 버튼 부분 아닌 곳 클릭했을 경우 x표시 나타나기
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bgBeige
        setLayout()
    }
    
    // MARK: - Functions
    func putButtons(with predictions: [VNRecognizedObjectObservation]) {
        var createdButtons:[UIButton]=[]
        for prediction in predictions {
            createdButtons.append(createButton(prediction: prediction))
        }
        buttons = createdButtons
    }
    
    func createTargetListComponents(with predictions: Set<String>){
        var createdTargets:[TargetListComponentView]=[]
        for prediction in predictions {
            let component = TargetListComponentView()
            component.setData(korean: wordDictionary[prediction] ?? "사전 매칭 오류", english: prediction)
            createdTargets.append(component)
            
        }
        wordTargets = createdTargets
//        numberOfTargetWords = wordTargets.count
    }
    
    /// 인식된 객체마다 이에 맞는 버튼을 생성합니다.
    func createButton(prediction: VNRecognizedObjectObservation)-> UIButton {
        let buttonTitle: String? = prediction.label
        let color: UIColor = labelColor(with: buttonTitle ?? "N/A")
        print(prediction.boundingBox)
        print("image.frame",image.frame)
        print("image.bounds",image.bounds)
        //        let scale = CGAffineTransform.identity.scaledBy(x: image.bounds.width, y: image.bounds.height)
        //        print("scale",scale)
        //        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        //        print(prediction.boundingBox.origin.x,prediction.boundingBox.origin.y, prediction.boundingBox.width,prediction.boundingBox.height)
        //        let buttonRect = prediction.boundingBox.applying(scale)
        //        print(buttonRect)
        //        print(labelString,bgRect)
        //                let buttonRect = CGRect(x: prediction.boundingBox.origin.x, y: prediction.boundingBox.origin.y, width: prediction.boundingBox.width, height: prediction.boundingBox.height)
        let scale = CGAffineTransform.identity.scaledBy(x: buttonLayer.bounds.width, y: buttonLayer.bounds.height)
        print("scale",scale)
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
        let bgRect = prediction.boundingBox.applying(transform).applying(scale)
        
        
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
    
    func labelColor(with label: String) -> UIColor {
        if let color = colors[label] {
            return color
        } else {
            let color = UIColor(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 0.8)
            colors[label] = color
            return color
        }
    }
    
    func disableButtons(label:String){
        for button in buttons{
            if button.titleLabel?.text == label{
                button.isUserInteractionEnabled = false
            }
        }
    }
    
    func handleGuessedRightView(label:String){
        for wordTarget in wordTargets{
            if wordTarget.getTargetLabel() == label {
                wordTarget.handleGussedRightView()
            }
        }
    }
}

// MARK: - UI
extension GameVC {
    func setLayout() {
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

// MARK: - Core ML
extension GameVC {
    func setUpModel() {
        if let visionModel = try? VNCoreMLModel(for: objectDectectionModel.model) {
            self.visionModel = visionModel
            request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
            request?.imageCropAndScaleOption = .scaleFit
        } else {
            fatalError("fail to create vision model")
        }
    }
    
    /// 사진이 선택되면 pixelBuffer 값 역시 할당됩니다. 할당된 값을 이용하여 객체 인식을 시작합니다.
    func handleImage(pixelBuffer: CVPixelBuffer?){
        if !self.isInferencing, let pixelBuffer = pixelBuffer {
            self.isInferencing = true
            self.predictUsingVision(pixelBuffer: pixelBuffer)
        }
    }
    
    func predictUsingVision(pixelBuffer: CVPixelBuffer) {
        guard let request = request else { fatalError() }
        self.semaphore.wait()
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
    }
    
    /// 객체 인식이 끝나고 나면 인식 결과를 프로퍼티에 저장하고 버튼을 올릴 레이어를 준비합니다.
    func visionRequestDidComplete(request: VNRequest, error: Error?) {
        if let predictions = request.results as? [VNRecognizedObjectObservation] {
            DispatchQueue.main.async {
                //  self.buttonLayer.bounds = self.image.bounds
                self.image.addSubview(self.buttonLayer)
                // self.image.layer.addSublayer(buttonLayer)
                self.buttonLayer.frame = self.image.bounds
                self.predictedObjects = predictions
                self.isInferencing = false
            }
        }
        self.isInferencing = false
        self.semaphore.signal()
    }
}