//
//  ExtensionVideo.swift
//  AirCloset
//
//  Created by cql200 on 02/06/23.
//

import Foundation
import Foundation
//import MobileCoreServices
import AVKit
import UIKit

class ImagePickerClass: NSObject{
    
    var imagePicker = UIImagePickerController()
    var pickedImage:((UIImage)->())?
    var pickImageCallback : ((ImageStructInfo) -> ())?
    var pathUrl : ((URL)->())?
    func initialize(){
        imagePicker.delegate = self
    }
    
//    func showImagePicker(){
//        let alert = UIAlertController(title: "Select Source", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
//        let openCamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (data) in
//            self.openCamera()
//        }
//        let openGalary = UIAlertAction(title: "Gallery/Video", style: .default) { (data) in
//            self.openGallery()
//        }
//        let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
//        alert.addAction(openCamera)
//        alert.addAction(openGalary)
//        alert.addAction(cancelBtn)
//        rootVC?.present(alert, animated: true, completion: nil)
//    }
    
    func showOnlyVideoPicker(){
        let alert = UIAlertController(title: "Select Source", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let openCamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (data) in
            self.onlyVidoeCamera()
        }
        let openGalary = UIAlertAction(title: "Gallery/Video", style: .default) { (data) in
            self.openOnlyVideo()
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(openCamera)
        alert.addAction(openGalary)
        alert.addAction(cancelBtn)
        rootVC?.present(alert, animated: true, completion: nil)
    }
    
    func showOnlyImagePicker(){
        let alert = UIAlertController(title: "Select Source", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let openCamera = UIAlertAction(title: "Camera", style: UIAlertAction.Style.default) { (data) in
            self.onlyPhotoCamera()
        }
        let openGalary = UIAlertAction(title: "Gallery/Video", style: .default) { (data) in
            self.openOnlyPhoto()
        }
        let cancelBtn = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alert.addAction(openCamera)
        alert.addAction(openGalary)
        alert.addAction(cancelBtn)
        rootVC?.present(alert, animated: true, completion: nil)
    }
    
    
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image", "public.movie"]
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have camera"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    func onlyVidoeCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.movie"]
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have camera"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func onlyPhotoCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image"]
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have camera"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func openOnlyPhoto(){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.isEditing = true
            self.imagePicker.mediaTypes = ["public.image"]
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have gallary"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openOnlyVideo() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.isEditing = true
            self.imagePicker.mediaTypes = ["public.movie"]
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have gallary"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.isEditing = true
            self.imagePicker.mediaTypes = ["public.image", "public.movie"]
            rootVC?.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController()
            alert.title = "You don't have gallary"
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(okAction)
            rootVC?.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension ImagePickerClass:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
//

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        var image = UIImage()
        var videoURL: URL?

        if let imageOriginal = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            pickedImage?(imageOriginal)
            image = imageOriginal
            var imageInfo : ImageStructInfo
            let formatter = DateFormatter()
            formatter.dateFormat = dateFormat.timeAmPm.rawValue
            let date = formatter.string(from: Date())
            imageInfo = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "image/jpeg", data:image.toData() , key: "post")
           
            pickImageCallback?(imageInfo)
        }else{
            if let media =  info[UIImagePickerController.InfoKey.mediaURL] as? URL {
                  var imageInfo : ImageStructInfo
                  do
                  {
                      let imageData = try Data(contentsOf: media as URL)
                      let formatter = DateFormatter()
                      formatter.dateFormat = dateFormat.fullDate.rawValue
                      let date = formatter.string(from: Date())
                      imageInfo = ImageStructInfo.init(fileName: "video.mp4", type: "video/mp4", data:imageData , key: "video")
                      pathUrl?(media)
                      pickImageCallback?(imageInfo)
                  } catch {
                      print("Unable to load data: \(error)")
                  }
                
              }else{
                 image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
                pickedImage?(image)
                var imageInfo1 : ImageStructInfo
                let formatter = DateFormatter()
                formatter.dateFormat = dateFormat.fullDate.rawValue
                let date = formatter.string(from: Date())
                imageInfo1 = ImageStructInfo.init(fileName: "Img\(date).jpeg", type: "image/jpeg", data:image.toData() , key: "post")
                pickImageCallback?(imageInfo1)
             }

        }
    }
}


func getThumbnail(from videoURL: URL, completion: @escaping (UIImage?) -> Void) {
    let asset = AVAsset(url: videoURL)
    let assetGenerator = AVAssetImageGenerator(asset: asset)
    let time = CMTime(seconds: 1, preferredTimescale: 1)
    assetGenerator.generateCGImagesAsynchronously(forTimes: [NSValue(time: time)]) { _, image, _, _, _ in
        if let thumbnailImage = image {
            let uiImage = UIImage(cgImage: thumbnailImage)
            completion(uiImage)
        } else {
            completion(nil)
        }
    }
}


func fetchImages(from urls: [URL], completion: @escaping ([UIImage?]) -> Void) {
    let session = URLSession.shared
    var images: [UIImage?] = []
    let downloadGroup = DispatchGroup()

    for url in urls {
        downloadGroup.enter()

        let task = session.dataTask(with: url) { data, _, error in
            defer { downloadGroup.leave() }

            if let error = error {
                print("Error downloading image from \(url): \(error)")
                images.append(nil)
            } else if let data = data, let image = UIImage(data: data) {
                images.append(image)
            } else {
                images.append(nil)
            }
        }
        task.resume()
    }

    downloadGroup.notify(queue: DispatchQueue.main) {
        completion(images)
    }
}

