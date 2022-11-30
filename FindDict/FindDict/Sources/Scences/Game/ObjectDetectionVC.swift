//
//  ObjectDetectionVC.swift
//  FindDict
//
//  Created by 김지민 on 2022/11/26.
//

import UIKit
import Vision

protocol ObjectDetectionVCDelegate: AnyObject {
    func lackOfObject()
}

final class ObjectDetectionVC: UIViewController {

    // MARK: - Vision Properties
    private var request: VNCoreMLRequest?
    private var visionModel: VNCoreMLModel?
    private var isInferencing: Bool = false
    private let semaphore: DispatchSemaphore = DispatchSemaphore(value: 1)
    private let objectDectectionModel = yolov7()
//    yolov5m() //
    private var gameVC: GameVC = GameVC()
    private var navigation: UINavigationController?
    private var delegate: ObjectDetectionVCDelegate?
        
    private var pixelBuffer: CVPixelBuffer? = nil {
        didSet{
            configureModel()
            handleImage(pixelBuffer: pixelBuffer)
        }
    }
    
    private var predictedObjects: [VNRecognizedObjectObservation] = [] {
        didSet {
            var predectedObjectLabels = Set<String>()
            for predictedObject in predictedObjects {
                predectedObjectLabels.insert(predictedObject.label ?? "레이블오류")
            }
            print("ObjectDetectionVC",predectedObjectLabels)
            if (predectedObjectLabels.count < 3 ){
                self.delegate?.lackOfObject()
            }else {
                gameVC.setPredictedObjects(predictedObjects: predictedObjects)
                gameVC.setPredictedObjectLableSet(predictedObjectLableSet: predectedObjectLabels)
                self.navigation?.pushViewController(gameVC, animated: true)
            }
        }
    }
    
    func setDelegate(delegate: ObjectDetectionVCDelegate){
        self.delegate = delegate
    }
    
    func setGameVC(gameVC: GameVC){
        self.gameVC = gameVC
    }
    
    func setPixelBuffer(pixelBuffer: CVPixelBuffer?){
        self.pixelBuffer = pixelBuffer
    }
    
    func setNavigationController(navigationController: UINavigationController?){
        self.navigation = navigationController
    }
    
    
    private func configureModel() {
        if let visionModel = try? VNCoreMLModel(for: objectDectectionModel.model) {
            self.visionModel = visionModel
            request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete)
            request?.imageCropAndScaleOption = .scaleFit
        } else {
            fatalError("fail to create vision model")
        }
    }
    
    /// 사진이 선택되면 pixelBuffer 값 역시 할당됩니다. 할당된 값을 이용하여 객체 인식을 시작합니다.
    private func handleImage(pixelBuffer: CVPixelBuffer?){
        if !self.isInferencing, let pixelBuffer = pixelBuffer {
            self.isInferencing = true
            self.predictUsingVision(pixelBuffer: pixelBuffer)
        }
    }
    
    private func predictUsingVision(pixelBuffer: CVPixelBuffer) {
        guard let request = request else { fatalError() }
        self.semaphore.wait()
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
    }
    
    /// 객체 인식이 끝나고 나면 인식 결과를 프로퍼티에 저장하고 버튼을 올릴 레이어를 준비합니다.
    private func visionRequestDidComplete(request: VNRequest, error: Error?) {
        if let predictions = request.results as? [VNRecognizedObjectObservation] {
                self.predictedObjects = predictions
        }
        self.isInferencing = false
        self.semaphore.signal()
    }
}

extension VNRecognizedObjectObservation {
    var label: String? {
        return self.labels.first?.identifier
    }
}
