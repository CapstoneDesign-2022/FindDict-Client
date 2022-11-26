//
//  ObjectDetectionVC.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/26.
//

import UIKit
import Vision

class ObjectDetectionVC: UIViewController {
    
    // MARK: - Vision Properties
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    var isInferencing: Bool = false
    let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    private let objectDectectionModel = yolov5m() //yolov7()
    var gameVC = GameVC()
    var navigation: UINavigationController?
    
//    var image: UIImageView = UIImageView()
    
    var pixelBuffer: CVPixelBuffer? = nil {
        didSet{
            setUpModel()
            handleImage(pixelBuffer: pixelBuffer)
        }
    }
    
    var predictedObjects: [VNRecognizedObjectObservation] = [] {
        didSet {
            gameVC.putButtons(with: predictedObjects)
            var predectedObjectLabels = Set<String>()
            for predictedObject in predictedObjects {
                predectedObjectLabels.insert(predictedObject.label ?? "레이블오류")
            }
            gameVC.predictedObjectLableSet = predectedObjectLabels
            print(">>>>NAvigatae")
                self.navigation?.pushViewController(gameVC, animated: true)
        }
    }
    
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
            DispatchQueue.main.async { [self] in
                //  self.buttonLayer.bounds = self.image.bounds
                gameVC.image.addSubview(self.gameVC.buttonLayer)
                // self.image.layer.addSublayer(buttonLayer)
                gameVC.buttonLayer.frame = gameVC.image.bounds
                self.predictedObjects = predictions
                self.isInferencing = false
            }
        }
        self.isInferencing = false
        self.semaphore.signal()
//        gameVC.setDelegate(delegate: self)
//        gameVC.image.image = selectedImage.image
//        gameVC.image.image = image.image
   
    }
}

extension VNRecognizedObjectObservation {
    var label: String? {
        return self.labels.first?.identifier
    }
}
