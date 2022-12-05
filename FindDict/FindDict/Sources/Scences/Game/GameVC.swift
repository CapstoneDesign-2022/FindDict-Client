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
    private let cropImageView: UIImageView = UIImageView()
    
private var cropImage: UIImage = UIImage(){
        didSet{
            cropImageView.image = cropImage
            for word in predictedObjectLableSet{
                requestPostWord(body: CreateWordBodyModel(english: word), image: (cropImage ?? UIImage(named: "GameOver"))!)
            }
        }
    }
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
//                print("11111111111",buttonLayer.bounds.height)
                buttonLayer.addSubview(button)
                print("******",button.frame)
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
            let createdButton = createButton(prediction: prediction)
            createdButtons.append(createdButton)
            
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
        
//        print("222222222222",buttonLayer.bounds.height)
        let scale = CGAffineTransform.identity.scaledBy(x: buttonLayer.bounds.width, y: buttonLayer.bounds.height)
    
        let bgRect = prediction.boundingBox.applying(scale)
        
//        let cropScale = CGAffineTransform.identity.scaledBy(x: image.bounds.width, y: image.bounds.height)
//        let cropBgRect = prediction.boundingBox.applying(cropScale)
//        print(image.image.)
//        print(">>>>>",bgRect)
        cropImage(buttonTitle ?? "dpfj", bgRect)
//        print(bgRect)
//        let x = (prediction.boundingBox.origin.x - prediction.boundingBox.size.width/2)*image.frame.size.width
//        let y = (prediction.boundingBox.origin.y - prediction.boundingBox.size.height/2)*image.frame.size.height
//        let width = prediction.boundingBox.size.width * image.frame.size.width
//        let height = prediction.boundingBox.size.height * image.frame.size.height
//        print(x,y,width,height)
//        cropImage(origin: CGPoint(x: x, y: y),size: CGSize(width: width, height: height))
        //        cropImage(origin: CGPoint(x: x, y: y),size: CGSize(width: width, height: height))
        
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
    
    func resize(image: CGImage, scale: CGFloat, completionHandler: (CGImage?) -> UIImage)
    {
      let size = CGSize(width: CGFloat(image.width), height: CGFloat(image.height))
      let context = CGContext( // #1
           data: nil,
           width: Int(size.width * scale),
           height: Int(size.height * scale),
           bitsPerComponent: 8,
           bytesPerRow: 0,
           space: CGColorSpaceCreateDeviceRGB(),
           bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
      context.interpolationQuality = .high // #2
      context.draw(image, in: CGRect(origin:.zero, size:size))
      let resultImage = context.makeImage()
      completionHandler(resultImage)
    }
    
    func resizeImage(image: UIImage, size: CGSize, x: CGFloat, y: CGFloat) -> CGImage {
        UIGraphicsBeginImageContext(size)
        print("xxxxxxxxx",x)
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
        
    
//        var cropRect = CGRect(origin: cropRect.origin, size: CGSize(width: cropRect.size.width*10, height: cropRect.size.height*10))
//        var cropRect = CGRect(x: cropRect.origin.x, y: cropRect.origin.y, width: cropRect.width, height: cropRect.height)
//        let transform = CGAffineTransform(scaleX: 1, y: -1)
//        cropRect = cropRect.applying(transform)
        print("<<<<<<<",title, cropRect, buttonLayer.bounds)
//        let resizedImage
//        let newImage = resize(image: (image.image?.cgImage)!, scale: 0.5, completionHandler: {image in
//            let imageRef = image?.cropping(to: cropRect)
//            let newImage = UIImage(cgImage: (imageRef ?? self.image.image?.cgImage)!, scale: 1, orientation: self.image.image!.imageOrientation)
//            return newImage as! UIImage
//        })
        
        var newImage = resizeImage(image: image.image!, size: buttonLayer.bounds.size, x: buttonLayer.bounds.origin.x, y: buttonLayer.bounds.origin.y)
        
//        resize(.)
//        image.image?.cgImage.cr
        guard let imageRef = newImage.cropping(to: cropRect) else { return  };
        print(image.image?.size)
//        let newImage = UIImage(cgImage: imageRef, scale: 1, orientation: image.image!.imageOrientation)
        //        print("origin",origin)
        //        print("size",size)
        //        let cropRect = CGRect(origin: origin, size: size)
        //
        //        print("!!!!!!!!",image.image!.scale, image.image!.imageOrientation)
        //        print("!!~!~!~!~!",image.image?.size.width , image.image?.size.height)
        //        let scale = CGAffineTransform.identity.scaledBy(x: 1 / (image.image?.size.width ?? 1106), y: 1 / (image.image?.size.height ?? 1266) )
        //        let modifiedCroppingRect = cropRect.applying(scale)
        //        print("######",cropRect,modifiedCroppingRect)
        //        guard let imageRef = image.image?.cgImage?.cropping(to: modifiedCroppingRect) else { return  };
        //        let imageRect = image.contentClippingRect
        //        let newImage = UIImage(cgImage: imageRef, scale: 1.0, orientation: image.image!.imageOrientation)
//        cropImageView.image = newImage
         let newUIImage = UIImage(cgImage: imageRef, scale: 1, orientation: self.image.image!.imageOrientation)
        cropImage = newUIImage
//        print(cropImageView.image)
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
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(100)
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            $0.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
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
