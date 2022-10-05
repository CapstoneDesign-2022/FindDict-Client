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
//            print("pixel buffer set")
            setUpModel()
            handleImage(pixelBuffer: pixelBuffer)
        }
    }
    var image = UIImageView()
    
    let objectDectectionModel = yolov5m()
    //    yolov7()
    //yolov5m()
    var predictions: [VNRecognizedObjectObservation] = []
    var label: String? {
        return predictions.first?.labels.first?.identifier
    }
    lazy var buttons: [UIButton] = [] {
        
        didSet{
//            print("buttons",buttons)
            for button in buttons {
                print(button.titleLabel?.text)
//                print("buttonTitle",image.subviews)
//                button.addTarget(nil,action: #selector(buttonClicked), for: .touchUpInside)
                button.press{
                    
                    button.setImage(UIImage(named: "icon"), for: .normal)
                }
                image.addSubview(button)
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
//        print("view did load")
        setLayout()
//        print(image.subviews) //???: 빈 배열 나옴
//        image.subviews.forEach({view in
//                        type(of: view) == UIButton.self
//                        if (view is UIButton) {
//                            view.addTarget(self,action: #selector(buttonClicked), for: .touchUpInside)
//                        }
//            print(view)
//            if let button = view as? UIButton {
//                print(button.titleLabel?.text)
//                button.addTarget(self,action: #selector(buttonClicked), for: .touchUpInside)
//
//            }
//        }) //???: subviews가 빈 배열이라 수행 안 됨
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
                //                self.image.layer.addSublayer(boxesView)
                //                self.boxesView.bounds = self.image.bounds
                //                self.boxesView.bounds = self.image.frame
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
//            image.setNeedsDisplay()
        }
    }
    
    func putButtons(with predictions: [VNRecognizedObjectObservation]) {
        //        subviews.forEach({ $0.removeFromSuperview() })
        var createdButtons:[UIButton]=[]
        for prediction in predictions {
            createdButtons.append(createButton(prediction: prediction))
            
        }
        buttons = createdButtons
    }
    
    func createButton(prediction: VNRecognizedObjectObservation)-> UIButton {
//        print("create button")
        let buttonTitle: String? = prediction.label
        let color: UIColor = labelColor(with: buttonTitle ?? "N/A")
        //        let scale = CGAffineTransform.identity.scaledBy(x: image.bounds.width, y: image.bounds.height)
        //        print("scale",scale)
        //        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -1)
//        print(prediction.boundingBox.origin.x,prediction.boundingBox.origin.y, prediction.boundingBox.width,prediction.boundingBox.height)
        //        let buttonRect = prediction.boundingBox.applying(scale)
        //        print(buttonRect)
        //        print(labelString,bgRect)
        //        let buttonRect = CGRect(x: prediction.boundingBox.origin.x, y: prediction.boundingBox.origin.y, width: prediction.boundingBox.width, height: prediction.boundingBox.height)
        //TODO: 스케일 맞추기
        let buttonRect = CGRect(x: prediction.boundingBox.origin.x*500, y: prediction.boundingBox.origin.y*500, width: prediction.boundingBox.width*500, height: prediction.boundingBox.height*500)
//        let button = UIButton(frame: buttonRect)
        let button = UIButton(type: .custom)
        button.frame = buttonRect
        button.layer.borderColor = color.cgColor
        button.backgroundColor = .systemBlue
        button.layer.borderWidth = 4
        button.backgroundColor = UIColor.clear
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.alpha = 0
        
//        buttons.append(button)
        
//        button.addTarget(nil,action: #selector(buttonClicked), for: .touchUpInside)
//        image.addSubview(button)
//        print("buttonTitle",image.subviews)
//                button.press{
//                    print(buttonTitle)
//                    button.setImage(UIImage(named: "icon"), for: .normal)
//                }
//        image.setNeedsDisplay()
//        image.layoutIfNeeded()
        return button
    }
    @objc func buttonClicked(_ sender:UIButton) -> Void {
//        print(sender.titleLabel?.text)
        print("Clicked")
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
