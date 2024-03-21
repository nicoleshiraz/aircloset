//
//  ImagePickerManager.swift
//  Monero
//
//  Created by dr.mac on 01/03/23.
//

import Foundation
import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var picker = UIImagePickerController()
    var alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
    var viewController: UIViewController?
    var pickImageCallback : ((UIImage) -> ())?
    static let shared = ImagePickerManager()
    
    override init(){
        super.init()
//       picker.allowsEditing = true
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> ())) {
        pickImageCallback = callback;
        self.viewController = viewController;
        alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default){
            UIAlertAction in
            self.openCamera()
        }
        let gallaryAction = UIAlertAction(title: "Gallery", style: .default){
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = self.viewController!.view
        }
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        alert.dismiss(animated: true, completion: nil)
        DispatchQueue.main.async {
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                self.picker.sourceType = .camera
                self.viewController!.present(self.picker, animated: true, completion: nil)
            } else {
                print("You don't have camera")
                // UIAlertController.showAlert("", message: "You don't have camera", buttons: ["Ok"], completion: nil)
            }
        }
    }
    
    func openGallery(){
        DispatchQueue.main.async {
            self.alert.dismiss(animated: true, completion: nil)
            self.picker.sourceType = .photoLibrary
            self.viewController!.present(self.picker, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        var image = UIImage()
        if let imageOriginal = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = imageOriginal
        } else {
            image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        }
        pickImageCallback?(image)
    }
    
    //  // For Swift 4.2
    //  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    //      picker.dismiss(animated: true, completion: nil)
    //      guard let image = info[.originalImage] as? UIImage else {
    //          fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
    //      }
    //      pickImageCallback?(image)
    //  }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, pickedImage: UIImage?) {
        
    }
}

