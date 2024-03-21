//
//  Extension.swift
//  AirCloset
//
//  Created by cql200 on 05/05/23.
//

import AVKit
import UIKit
import Foundation
import Kingfisher
import CoreLocation

extension String{
    
    var isBlank : Bool
    {
        if self.count == 0 || self.trimmingCharacters(in: .whitespaces).isEmpty == true{
            return true
        }else{
            return false
        }
    }
    
    var isValidEmail: Bool {
        
        let regex = try? NSRegularExpression(pattern: "^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$", options: .caseInsensitive)
        
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
}
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.utf16.count
        } else {
            return false
        }
    }
}

extension UIViewController {
    func createCenteredImageView(image: UIImage?, width: CGFloat, height: CGFloat) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: width),
            imageView.heightAnchor.constraint(equalToConstant: height)
        ])
        
        return imageView
    }
}

//MARK: SHOW - IMAGE PICKER
extension UIImageView{
    func imageLoad(imageUrl:String)   {
        let url = URL(string: imageUrl)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "iconPlaceHolder"),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
    
}

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}



extension UITableView {
    
    func setEmptyData(msg : String, rowCount : Int) {
        
        let noDataLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height ))
        noDataLbl.text =  msg
        noDataLbl.textAlignment = .center
        noDataLbl.textColor = .black //UIColor(red: 255/255, green: 90/255, blue: 0/255, alpha: 1.0)
        self.backgroundView = noDataLbl
        if rowCount != 0 {
            self.backgroundView = UIView()
        }else {
            self.backgroundView = noDataLbl
        }
    }
    
    func removeEmptyMessage() {
        self.backgroundView = UIView()
    }
}


extension UICollectionView {
    
    func setEmptyData(msg : String, rowCount : Int) {
        
        let noDataLbl = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height ))
        noDataLbl.text =  msg
        noDataLbl.textAlignment = .center
        noDataLbl.textColor = .black //UIColor(red: 255/255, green: 90/255, blue: 0/255, alpha: 1.0)
        self.backgroundView = noDataLbl
        if rowCount != 0 {
            self.backgroundView = UIView()
        }else {
            self.backgroundView = noDataLbl
        }
    }
    
    func removeEmptyMessage() {
        self.backgroundView = UIView()
    }
}

extension UITableView {
    func scrollToBottom(animated: Bool) {
        DispatchQueue.main.async {
            if self.contentSize.height > self.frame.height {
                let lastSectionIndex = self.numberOfSections - 1
                let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
                let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                self.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            }
        }
    }
}

extension String {
    func capitalizeFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}

func generateThumbnailImage(from videoURL: URL, completion: @escaping (UIImage?) -> Void) {
    let asset = AVAsset(url: videoURL)
    let imageGenerator = AVAssetImageGenerator(asset: asset)

    // Specify the time at which you want to capture the thumbnail (e.g., 1 second into the video)
    let time = CMTime(seconds: 1, preferredTimescale: 1)

    do {
        let thumbnailCGImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
        let thumbnailImage = UIImage(cgImage: thumbnailCGImage)
        completion(thumbnailImage)
    } catch {
        print("Error generating thumbnail image: \(error)")
        completion(nil)
    }
}


extension AVPlayer {
    static func playVideo(from url: URL) -> AVPlayer? {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        // Get the topmost view controller to present the player view controller
        if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
            topViewController.modalPresentationStyle = .formSheet
            topViewController.present(playerViewController, animated: true) {
                player.play()
            }
        }
        
        return player
    }
}


func getImageData(selectedImage: UIImage,key:String = "image") -> ImageStructInfo {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat.BackEndFormat.rawValue
    let date = formatter.string(from: Date())
    let imageInfo : ImageStructInfo
    imageInfo = ImageStructInfo.init(fileName: "thumbnail\(date).jpeg", type: "img/jpeg", data: selectedImage.toData(), key: key)
    return imageInfo
}

func getImageData2(selectedImage: UIImage,key:String = "image") -> ImageStructInfo {
    let formatter = DateFormatter()
    formatter.dateFormat = dateFormat.BackEndFormat.rawValue
    let date = formatter.string(from: Date())
    let imageInfo : ImageStructInfo
    imageInfo = ImageStructInfo.init(fileName: "idVerification.jpeg", type: "img/jpeg", data: selectedImage.toData(), key: key)
    return imageInfo
}

extension Date {
    @available(iOS 13.0, *)
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

func convertStrToDate(strDate: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    let date = dateFormatter.date(from: strDate)

    if let date = date {
        print(date) // Output: 2023-05-30 09:30:00 +0000
    } else {
        print("Invalid date string")
    }
    return date ?? Date()
}

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLengthh: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        if let t = textField.text {
            textField.text = String(t.prefix(maxLengthh))
        }
    }
}

func isStartDateInPast(startDateStr: String) -> Bool {
    // Define a date formatter for the specified date format
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/yy"
    
    // Attempt to convert the start date string to a Date object
    if let startDate = dateFormatter.date(from: startDateStr) {
        // Get the current date
        let currentDate = Date()
        
        // Compare the start date with the current date
        return startDate < currentDate
    } else {
        print("Invalid date format")
        return false
    }
}


func isStartDateInPastButNotToday(startDateStr: String) -> Bool {
    // Define a date formatter for the specified date format
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd/MM/yy"
    
    // Attempt to convert the start date string to a Date object
    if let startDate = dateFormatter.date(from: startDateStr) {
        // Get the current date
        let currentDate = Date()
        
        // Compare the start date with the current date
        return startDate < currentDate && !Calendar.current.isDate(startDate, inSameDayAs: currentDate)
    }
    return false
}


import UIKit

@IBDesignable
class GradientLabel: UILabel {
    @IBInspectable var startGradientColor: UIColor? {
        didSet {
            applyGradient()
        }
    }

    @IBInspectable var endGradientColor: UIColor? {
        didSet {
            applyGradient()
        }
    }

    @IBInspectable var gradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            applyGradient()
        }
    }

    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            applyGradient()
        }
    }

    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startGradientColor?.cgColor ?? UIColor.clear.cgColor, endGradientColor?.cgColor ?? UIColor.clear.cgColor]
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint

        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}



@IBDesignable
class GradientButton: UIButton {
    @IBInspectable var startGradientColor: UIColor? {
        didSet {
            applyGradient()
        }
    }

    @IBInspectable var endGradientColor: UIColor? {
        didSet {
            applyGradient()
        }
    }

    @IBInspectable var gradientStartPoint: CGPoint = CGPoint(x: 0.5, y: 0) {
        didSet {
            applyGradient()
        }
    }

    @IBInspectable var gradientEndPoint: CGPoint = CGPoint(x: 0.5, y: 1) {
        didSet {
            applyGradient()
        }
    }

    private func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [startGradientColor?.cgColor ?? UIColor.clear.cgColor, endGradientColor?.cgColor ?? UIColor.clear.cgColor]
        gradientLayer.startPoint = gradientStartPoint
        gradientLayer.endPoint = gradientEndPoint

        layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }
        layer.insertSublayer(gradientLayer, at: 0)
    }
}


func getAddress(lat: Double, lng: Double,handler: @escaping (String) -> Void) {
    var address: String = ""
    let geoCoder = CLGeocoder()
    let location = CLLocation(latitude: lat, longitude: lng)
    geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        var placeMark: CLPlacemark?
        placeMark = placemarks?[0]
        
        if let city = placeMark?.addressDictionary?["City"] as? String {
            address += city + " "
        }
        if let zip = placeMark?.addressDictionary?["ZIP"] as? String {
            address += zip + " "
        }
        if let country = placeMark?.addressDictionary?["Country"] as? String {
            address += country
        }
       handler(address)
    })
}


extension Double {
    func rounded(toDecimalPlaces places: Int) -> Double {
        let multiplier = pow(10.0, Double(places))
        return (self * multiplier).rounded() / multiplier
    }
}
