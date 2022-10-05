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
    
    var pixelBuffer:CVPixelBuffer? = nil {
        didSet{
            setUpModel()
            handleImage(pixelBuffer: pixelBuffer)
        }
    }
    var image = UIImageView()
    
    let objectDectectionModel = yolov7()
    //    yolov5m()
    var predictions: [VNRecognizedObjectObservation] = []
    
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
            print(predictions.first?.labels.first?.identifier ?? "nil")
            print(predictions.first?.labels.first?.confidence ?? -1)
            
            DispatchQueue.main.async {
                //                self.image.layer.addSublayer(boxesView)
//                self.boxesView.bounds = self.image.bounds
                //                self.boxesView.bounds = self.image.frame
                
//                self.boxesView.predictedObjects = predictions
                self.predictedObjects = predictions
                self.isInferencing = false
            }
            
//            self.predictions = predictions
            
//            print(predictions)
            
        }
        self.isInferencing = false
        self.semaphore.signal()
    }
    
    public var predictedObjects: [VNRecognizedObjectObservation] = [] {
        didSet {
            putButtons(with: predictedObjects)
//            setNeedsDisplay()
        }
    }
    
    var label: String? {
        return predictions.first?.labels.first?.identifier
    }
    
    func putButtons(with predictions: [VNRecognizedObjectObservation]) {
//        subviews.forEach({ $0.removeFromSuperview() })
        
        for prediction in predictions {
//            createLabelAndBox(prediction: prediction)
            createButton(prediction: prediction)
        }
    }
    
    func createButton(prediction: VNRecognizedObjectObservation) {
        let buttonTitle: String? = prediction.label
        
//        let scale = CGAffineTransform.identity.scaledBy(x: image.bounds.width, y: image.bounds.height)
//        print("scale",scale)
//        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
//        print(buttonTitle,"boundingBox",prediction.boundingBox)
//        print(prediction.boundingBox.origin.x,prediction.boundingBox.origin.y, prediction.boundingBox.width,prediction.boundingBox.height)
//        let buttonRect = prediction.boundingBox.applying(scale)
//        print(buttonRect)
//        print(labelString,bgRect)
//        let buttonRect = CGRect(x: prediction.boundingBox.origin.x, y: prediction.boundingBox.origin.y, width: prediction.boundingBox.width, height: prediction.boundingBox.height)
        
        let buttonRect = CGRect(x: prediction.boundingBox.origin.x*300, y: prediction.boundingBox.origin.y*300, width: 30, height: 30)
        print(buttonRect)
        let button = UIButton(frame: buttonRect)
//        bgView.layer.borderColor = color.cgColor
        button.backgroundColor = .systemBlue
//        button.
//        bgView.layer.borderWidth = 4
//        bgView.backgroundColor = UIColor.clear
//        addSubview(bgView)
        image.addSubview(button)
        
        let label = UILabel()
        label.text = buttonTitle ?? "N/A"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.black
//        label.backgroundColor = color
        label.sizeToFit()
        label.frame = CGRect(x: buttonRect.origin.x, y: buttonRect.origin.y - label.frame.height,
                             width: label.frame.width, height: label.frame.height)
//        print("label.frame",label.frame)
        image.addSubview(label)
//        addSubview(label)
    }
}
// MARK: - UI
extension ObjectDetectionVC {
    func setLayout() {
        view.addSubViews([image
//                          ,boxesView
                         ])
        image.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(17)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).inset(50)
        }
        
//        boxesView.snp.makeConstraints{
//            $0.edges.equalTo(image)
//        }
    }
}
