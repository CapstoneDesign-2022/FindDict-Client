//
//  PhotoSelectorVCViewController.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/27.
//

import UIKit
import SnapKit
import Then

final class PhotoSelectorVC: UIViewController {
    
    // MARK: - Properties
    private let gameVC: GameVC = GameVC()
    private let objectDetector: ObjectDetector = ObjectDetector()
    
    private let naviView = DefaultNavigationBar(isHomeButtonIncluded: true).then {
        $0.setTitleLabel(title: "Game")
    }
    
    private lazy var buttonStackView: UIStackView = UIStackView(arrangedSubviews: [takingPictureButton, selectingPictureButton, fetchingPictureButton]).then{
        $0.axis = .vertical
        $0.spacing = 30
        $0.distribution = .fillEqually
    }
    
    private let takingPictureButton: PhotoSelectorButton = PhotoSelectorButton().then{
        $0.setTitle("직접 사진 찍어 게임하기", for: .normal)
        $0.backgroundColor = .fdYellow
    }
    
    private let selectingPictureButton: PhotoSelectorButton = PhotoSelectorButton().then{
        $0.setTitle("앨범 속 사진으로 게임하기", for: .normal)
        $0.backgroundColor = .fdLightYellow
    }
    
    private let fetchingPictureButton: PhotoSelectorButton = PhotoSelectorButton().then{
        $0.setTitle("기본 이미지로 게임하기", for: .normal)
        $0.backgroundColor = .fdLightYellow
    }
    
    private let homeButton: UIButton = UIButton().then{
        $0.setImage(UIImage(named: "homeImage"),for: .normal)
    }
    
    private var selectedImage: UIImageView = UIImageView()
    
    private var pixelBuffer: CVPixelBuffer? = nil  {
        didSet{
            gameVC.image.image = selectedImage.image
            
            objectDetector.setNavigationController(navigationController: self.navigationController)
            objectDetector.setGameVC(gameVC: gameVC)
            objectDetector.setPixelBuffer(pixelBuffer: selectedImage.image?.pixelBufferFromImage())
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .fdBeige
        objectDetector.setDelegate(delegate: self)
        naviView.setDelegate(delegate: self)
    }
    
    // MARK: - Functions
    private func setButtonActions(){
        takingPictureButton.press{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        
        selectingPictureButton.press{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }
        fetchingPictureButton.press{
            self.selectedImage.image = UIImage(named: "defaultGameImage")
            self.pixelBuffer = self.selectedImage.image?.pixelBufferFromImage()
        }
    }
}

// MARK: - UI
extension PhotoSelectorVC {
    private func setLayout() {
        view.addSubViews([naviView, buttonStackView])

        naviView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        buttonStackView.snp.makeConstraints{
            $0.top.equalTo(naviView.snp.bottom).offset(50)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(80)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-80)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(200)
        }
    }
}

// MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension PhotoSelectorVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.editedImage] as? UIImage
        {
            selectedImage.image = image
            pixelBuffer = selectedImage.image?.pixelBufferFromImage()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - ObjectDetectorDelegate
extension PhotoSelectorVC: ObjectDetectorDelegate {
    func lackOfObject() {
        self.dismiss(animated: true)
        let photoReselectModalVC = PhotoReselectModalVC()
        photoReselectModalVC.modalPresentationStyle = .overCurrentContext
        self.present(photoReselectModalVC, animated: true)
    }
}

// MARK: - DefaultNavigationBarDelegate
extension PhotoSelectorVC: DefaultNavigationBarDelegate {
    func backButtonClicked(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func homeButtonClicked(){
        self.navigationController?.popToRootViewController(animated: false)
    }
}
