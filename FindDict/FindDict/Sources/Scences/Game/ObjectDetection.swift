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


class ObjectDetectionVC:ViewController {
    
    private let logoImage = UIImageView().then{
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(named: "logoImage")
    }
    
    private let targetListContainerView = UIStackView().then{
        $0.axis = .horizontal
//        $0.alignment = .fill
        $0.spacing = 20
//        $0.distribution = .fillProportionally
    }
    
    var pixelBuffer:CVPixelBuffer? = nil {
        didSet{
            setUpModel()
            handleImage(pixelBuffer: pixelBuffer)
        }
    }
    var image = UIImageView().then{
        $0.isUserInteractionEnabled = true
        $0.contentMode = .scaleAspectFit
    }
    var buttonLayer = UIView()
    
    let objectDectectionModel = yolov5m()
    //    yolov7()
    //yolov5m()
    var predictions: [VNRecognizedObjectObservation] = []
    var label: String? {
        return predictions.first?.labels.first?.identifier
    }
    
    lazy var buttons: [UIButton] = [] {
        didSet{
            for button in buttons {
                button.press{
                    button.setImage(UIImage(named: "icon"), for: .normal)
                    button.imageView?.contentMode = .scaleAspectFit
                    button.isUserInteractionEnabled = false
                    self.disableButtons(label:button.titleLabel?.text ?? "레이블 오류")
                    // TODO: 객체 리스트에서 같은 label인 버튼 비활성화
                    
                    // TODO: 객체 리스트에서 같은 label인 레이블 영어 단어 보여주기
                    
                }
                buttonLayer.addSubview(button)
            }
        }
    }
    
    lazy var wordTargets: [TargetListComponentView] = []{
        didSet{
            for wordTarget in wordTargets{
                targetListContainerView.addArrangedSubview(wordTarget)
            }
        }
    }
    
    func disableButtons(label:String){
        for button in buttons{
            if button.titleLabel?.text == label{
                button.isUserInteractionEnabled = false
            }
        }
    }
    
    // MARK: - Vision Properties
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    var isInferencing = false
    
    let semaphore = DispatchSemaphore(value: 1)
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    static private var colors: [String: UIColor] = [:]
    
    public func labelColor(with label: String) -> UIColor {
        if let color = ObjectDetectionVC.colors[label] {
            return color
        } else {
            let color = UIColor(hue: .random(in: 0...1), saturation: 1, brightness: 1, alpha: 0.8)
            ObjectDetectionVC.colors[label] = color
            return color
        }
    }
    
    // MARK: - Setup Core ML
    func setUpModel() {
        if let visionModel = try? VNCoreMLModel(for: objectDectectionModel.model) {
            self.visionModel = visionModel
            request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
            request?.imageCropAndScaleOption = .scaleFit
        } else {
            fatalError("fail to create vision model")
        }
    }
    
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
    
    // MARK: - Post-processing
    // 요청 실행 후
    func visionRequestDidComplete(request: VNRequest, error: Error?) {
        if let predictions = request.results as? [VNRecognizedObjectObservation] {
            DispatchQueue.main.async {
                self.image.addSubview(self.buttonLayer)
//                                self.image.layer.addSublayer(buttonLayer)
//                                self.buttonLayer.bounds = self.image.bounds
                                self.buttonLayer.frame = self.image.bounds
                self.predictedObjects = predictions
                self.isInferencing = false
            }
        }
        self.isInferencing = false
        self.semaphore.signal()
    }
    
    public var predictedObjects: [VNRecognizedObjectObservation] = [] {
        didSet {
            putButtons(with: predictedObjects)
//            predictedObjectsSet = Set(predictedObjects)
            var predectedObjectLabels = Set<String>()
            for predictedObject in predictedObjects {
                predectedObjectLabels.insert(predictedObject.label ?? "레이블오류")
            }
            predictedObjectLablesSet = predectedObjectLabels
        }
    }
    
    public var predictedObjectLablesSet = Set<String>() {
        didSet {
            createTargetListComponents(with: predictedObjectLablesSet)
        }
    }
    
    func putButtons(with predictions: [VNRecognizedObjectObservation]) {
        var createdButtons:[UIButton]=[]
        for prediction in predictions {
            createdButtons.append(createButton(prediction: prediction))
//            predictedObjectsSet.insert(prediction.label ?? "no label")
        }
        buttons = createdButtons
    }
    
    func createTargetListComponents(with predictions: Set<String>){
//        print(predictions)
        var createdTargets:[TargetListComponentView]=[]
        for prediction in predictions {
            let component = TargetListComponentView()
            component.setData(korean: wordDictionary[prediction] ?? "사전 매칭 오류", english: prediction)
            createdTargets.append(component)
            
        }
        wordTargets = createdTargets
    }
    
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
//        button.setTitleColor(.black, for: .normal)
//        button.setTitleColor(.systemRed, for: .disabled)
//        button.titleLabel?.alpha = 0
        return button
    }
//    @objc func buttonClicked(_ sender:UIButton) -> Void {
//        print(sender.titleLabel?.text)
//    }
}

// MARK: - UI
extension ObjectDetectionVC {
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
//            $0.leading.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.leading).inset(50)
//            $0.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.trailing).inset(50)
            $0.height.equalTo(100)
        }
        
        image.snp.makeConstraints{
            $0.top.equalTo(targetListContainerView.snp.bottom).offset(60)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
    }
}
