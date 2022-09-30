//
//  ObjectDetection.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/29.
//

import Foundation
import UIKit
import Vision

class ObjectDetection {
    
    //    private let
    
    let objectDectectionModel = yolov5m()
    var predictions: [VNRecognizedObjectObservation] = []
    
    // MARK: - Vision Properties
    var request: VNCoreMLRequest?
    var visionModel: VNCoreMLModel?
    var isInferencing = false
    
    let semaphore = DispatchSemaphore(value: 1)
    
    // MARK: - Setup Core ML
    func setUpModel() {
        
        // Vision 프레임워크의 요청 클래스와 호환되려면 반드시 모델을 VNCoreMLModel로 감싸서 인스턴스화.
        if let visionModel = try? VNCoreMLModel(for: objectDectectionModel.model) {
            
            // 모델 잘 감쌌으면 이를 visionModel에 저장.
            self.visionModel = visionModel
            
            // VNCoreMLRequest : 입력이미지를 할당된 CoreML 모델에 전달하기 전에 필요한 전처리 수행.
            // 전처리 수행한 결과를 visionRequestDidComplete가 받는다.
            request = VNCoreMLRequest(model: visionModel, completionHandler: visionRequestDidComplete) //1. 요청 정의
            
            // .centerCrop으로 하면 가로세로 비율 유지하면서 크기 조정하는데 필요한 경우 이미지 중앙을 기준으로 긴 쪽을 자른다.
            request?.imageCropAndScaleOption = .scaleFill
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
        // vision framework configures the input size of image following our model's input configuration automatically
        self.semaphore.wait()
        
        //2. 핸들러 정의
        let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer)
        try? handler.perform([request])
    }
    
    // MARK: - Post-processing
    // 요청 실행 후
    func visionRequestDidComplete(request: VNRequest, error: Error?) {
        
        // 결과 가져온 걸 처리, 뷰에 보여주기
        if let predictions = request.results as? [VNRecognizedObjectObservation] {
                        print(predictions.first?.labels.first?.identifier ?? "nil")
                        print(predictions.first?.labels.first?.confidence ?? -1)
            
            self.predictions = predictions
            print(predictions)
            
        }
        self.isInferencing = false
        self.semaphore.signal()
    }
    
}
