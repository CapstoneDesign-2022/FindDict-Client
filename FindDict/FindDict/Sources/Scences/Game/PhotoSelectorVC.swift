//
//  PhotoSelectorVCViewController.swift
//  FindDict
//
//  Created by 김지민 on 2022/09/27.
//

import UIKit
import SnapKit
import Then

class PhotoSelectorVC: UIViewController {
    
    // MARK: - Properties
    private let takingPictureButton = PhotoSelectorButton().then{
        $0.setTitle("사진 찍기", for: .normal)
        $0.backgroundColor = .buttonOrange
    }
    
    private let selectingPictureButton = PhotoSelectorButton().then{
        $0.setTitle("앨범에서 사진 선택", for: .normal)
        $0.backgroundColor = .buttonApricot
    }
    
    private let fetchingPictureButton = PhotoSelectorButton().then{
        $0.setTitle("기본 이미지", for: .normal)
        $0.backgroundColor = .buttonYellow
    }
    
    private var selectedImage = UIImageView()
    
    private var pixelBuffer:CVPixelBuffer? = nil  {
        didSet{
            let gameVC = GameVC()
            gameVC.image.image = selectedImage.image
            gameVC.pixelBuffer = selectedImage.image?.pixelBufferFromImage()
            self.navigationController?.pushViewController(gameVC, animated: true)
        }
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setButtonActions()
        view.backgroundColor = .bgBeige
    }
    
    // MARK: - Functions
    func setButtonActions(){
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
    }
}

// MARK: - UI
extension PhotoSelectorVC {
    private func setLayout() {
        view.addSubViews([takingPictureButton, selectingPictureButton,fetchingPictureButton])
        
        takingPictureButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(67)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(60)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            $0.height.equalTo(100)
        }
        
        selectingPictureButton.snp.makeConstraints{
            $0.top.equalTo(takingPictureButton.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(60)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            $0.height.equalTo(100)
        }
        
        fetchingPictureButton.snp.makeConstraints{
            $0.top.equalTo(selectingPictureButton.snp.bottom).offset(17)
            $0.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(60)
            $0.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-60)
            $0.height.equalTo(100)
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
