
//api request

import UIKit
import Foundation
import MBProgressHUD
import NVActivityIndicatorView

struct WebService {
    
    static let boundary = "Boundary-\(UUID().uuidString)"
    
    static func service<Model: Codable>(_ api: API, urlAppendId: Any? = nil, param: Any? = nil, service: Services = .post ,showHud: Bool = true, response:@escaping (Model,Data,Any) -> Void) {
        
//        var spinner : NVActivityIndicatorView?
        if Reachability.isConnectedToNetwork() {
            if showHud {
                DispatchQueue.main.async {
                    if let vc = UIApplication.shared.keyWindow{
                        MBProgressHUD.showAdded(to: vc, animated: true)
                    }}
//                DispatchQueue.main.async {
//                    if let vc = UIApplication.shared.keyWindow{
//                        //MBProgressHUD.showAdded(to: vc, animated: true)
//                        let spinnerWidth: CGFloat = 20
//                        let spinnerHeight: CGFloat = 20
//                        let padding: CGFloat = (vc.frame.width - spinnerWidth) / 2
//                        //    let padding: CGFloat = (isKeyWindow.frame.width - spinnerWidth) / 2
//                        spinner =  NVActivityIndicatorView.init(frame: (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.frame) ?? CGRect(x: 0, y: 0, width: spinnerWidth, height: spinnerHeight), type: .lineSpinFadeLoader, color: UIColor.lightGray , padding: padding)
//
//
//                        spinner?.startAnimating()
//                        (UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(spinner!))
//                        spinner?.startAnimating()
//                    }
//                }
            }
            
            var fullUrlString = baseURL + api.rawValue
            
            if let idApend = urlAppendId
            {
                fullUrlString = baseURL + api.rawValue + "/\(idApend)"
            }
            
            if service == .get{
                if let parm = param{
                    if parm is String{
                        fullUrlString.append("?")
                        fullUrlString += (parm as! String)
                    }else if parm is Dictionary<String, Any>{
                        fullUrlString += self.getString(from: parm as! Dictionary<String, Any>)
                    }else{
                        assertionFailure("Parameter must be Dictionary or String.")
                    }
                }
            }
            
            print(fullUrlString)
            print(param)
            
            guard let encodedString = fullUrlString.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else {return}
            var request = URLRequest(url: URL(string: encodedString)!, cachePolicy: URLRequest.CachePolicy.useProtocolCachePolicy, timeoutInterval: 2000)
            
            request.httpMethod = service.rawValue
            
            
            if let authKey = Store.authKey
            {
                
                request.addValue("Bearer " + authKey, forHTTPHeaderField: "authorization")
                print("authKey---\("Bearer " + authKey)")
                
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            //  request.addValue(publishKey, forHTTPHeaderField: "publish_key")
            
            request.addValue(securityKey, forHTTPHeaderField: "secretKey")
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            if service == .delete {
                request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                if let param = param{
                    if param is String{
                        let postData = NSMutableData(data: (param as! String).data(using: String.Encoding.utf8)!)
                        request.httpBody = postData as Data
                    }else if param is Dictionary<String, Any>{
                        var parm = self.getString(from: param as! Dictionary<String, Any>)
                        //print(parm)
                        parm.removeFirst()
                        let postData = NSMutableData(data: parm.data(using: String.Encoding.utf8)!)
                        request.httpBody = postData as Data
                    }
                }
            }
            
            if service == .post || service == .put{
                if let parameter = param{
                    if parameter is String{
                        request.httpBody = (parameter as! String).data(using: .utf8)
                    }else if parameter is Dictionary<String, Any>{
                        var body = Data()
                        for (key, Value) in parameter as! Dictionary<String, Any>{
                            //print(key,Value)
                            if let imageInfo = Value as? ImageStructInfo{
                                body.append("--\(boundary)\r\n")
                                body.append("Content-Disposition: form-data; name=\"\(imageInfo.key)\"; filename=\"\(imageInfo.fileName)\"\r\n")
                                body.append("Content-Type: \(imageInfo.type)\r\n\r\n")
                                body.append(imageInfo.data)
                                body.append("\r\n")
                            }
                            else if let images = Value as? [ImageStructInfo]{
                                for value in images{
                                    body.append("--\(boundary)\r\n")
                                    body.append("Content-Disposition: form-data; name=\"\(value.key)\"; filename=\"\(value.fileName)\"\r\n")
                                    body.append("Content-Type: \(value.type)\r\n\r\n")
                                    body.append(value.data)
                                    body.append("\r\n")
                                }
                            }else{
                                body.append("--\(boundary)\r\n")
                                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                                body.append("\(Value)\r\n")
                            }
                        }
                        body.append("--\(boundary)--\r\n")
                        request.httpBody = body
                    }else{
                        assertionFailure("Parameter must be Dictionary or String.")
                    }
                }
            }
            
            let sessionConfiguration = URLSessionConfiguration.default
            let session = URLSession(configuration: sessionConfiguration)
            
            session.dataTask(with: request) { (data, jsonResponse, error) in
                if showHud{
                    DispatchQueue.main.async {
                        if let vc = UIApplication.shared.keyWindow{
                            MBProgressHUD.hide(for: vc, animated: true)
                        }
                    }
                }
//                if showHud{
//                    DispatchQueue.main.async {
//                        if let vc = UIApplication.shared.keyWindow{
//                            spinner?.stopAnimating()
//                        }
//                    }
//                }
                if error != nil{
                    WebService.showAlert(error!.localizedDescription)
                }else{
                    if let jsonData = data{
                        do{
                            let jsonSer = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as! [String: Any]
                            print(jsonSer)
                            let codeInt = jsonSer["code"] as? Int ?? 0
                            let code = "\(codeInt)"
                            // let error = "\(codeInt)"
                            
                            if code == "400" || code == "403" || code == "401" {
                                
                                DispatchQueue.main.async {
                                    
                                    if let errorMessage = jsonSer["msg"] as? String{
                                        WebService.errorShowAlert(errorMessage)
                                    }else if let message = jsonSer["message"] as? String{
                                        CommonUtilities.shared.showSwiftAlert(message: message, isSuccess: .error)
                                        WebService.errorShowAlert(message)
                                    }
                                    if UIApplication.shared.isRegisteredForRemoteNotifications
                                    {
                                        UIApplication.shared.unregisterForRemoteNotifications()
                                        UIApplication.shared.registerForRemoteNotifications()
                                    }
                                    // Store.userDetails = nil
                                    if jsonSer["message"] as? String ?? "" == "Invalid authorization Key" {
                                        Store.autoLogin = false
                                        let storyb = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                                        let nav = UINavigationController.init(rootViewController: vc)
                                        nav.isNavigationBarHidden = true
                                        UIApplication.shared.windows.first?.rootViewController = nav
                                    } else if jsonSer["message"] as? String ?? "" == "Please Login First" {
                                        Store.autoLogin = false
                                        let storyb = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                                        let nav = UINavigationController.init(rootViewController: vc)
                                        nav.isNavigationBarHidden = true
                                        UIApplication.shared.windows.first?.rootViewController = nav
                                    }
                                }
                            } else if code == "402"{
                                DispatchQueue.main.async {
                                    if UIApplication.shared.isRegisteredForRemoteNotifications
                                    {
                                        UIApplication.shared.unregisterForRemoteNotifications()
                                        UIApplication.shared.registerForRemoteNotifications()
                                    }
                                    Store.autoLogin = false
                                    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                                    let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                                    let nav = UINavigationController.init(rootViewController: redViewController)
                                    nav.isNavigationBarHidden = true
                                    UIApplication.shared.windows.first?.rootViewController = nav
                                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                                }
                            } else if code != "200"{
                                DispatchQueue.main.async {
                                    if let errorMessage = jsonSer["msg"] as? String{
                                        CommonUtilities.shared.showSwiftAlert(message: errorMessage, isSuccess: .error)
                                        WebService.showAlert(errorMessage)
                                    }else if let message = jsonSer["message"] as? String{
                                        CommonUtilities.shared.showSwiftAlert(message: message, isSuccess: .error)
                                        WebService.showAlert(message)
                                    }
                                }
                            }else if code == "401"{
                                
                                if jsonSer["message"] as? String ?? "" == "Please Login First" {
                                    Store.autoLogin = false
                                    let storyb = UIStoryboard(name: "Main", bundle: nil)
                                    let vc = storyb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                                    let nav = UINavigationController.init(rootViewController: vc)
                                    nav.isNavigationBarHidden = true
                                    UIApplication.shared.windows.first?.rootViewController = nav
                                }
                                
                                DispatchQueue.main.async {
                                    if let errorMessage = jsonSer["msg"] as? String{
                                        WebService.showAlert(errorMessage)
                                    }else if let message = jsonSer["message"] as? String{
                                        WebService.showAlert(message)
                                    }
                                    
                                    if jsonSer["message"] as? String ?? "" == "Please Login First" {
                                        Store.autoLogin = false
                                        let storyb = UIStoryboard(name: "Main", bundle: nil)
                                        let vc = storyb.instantiateViewController(withIdentifier: "SignInVC") as! SignInVC
                                        let nav = UINavigationController.init(rootViewController: vc)
                                        nav.isNavigationBarHidden = true
                                        UIApplication.shared.windows.first?.rootViewController = nav
                                    }
                                    
                                }
                            } else {
                                let decoder = JSONDecoder()
                                let model = try decoder.decode(Model.self, from: jsonData)
                                DispatchQueue.main.async {
                                    response(model,jsonData,jsonSer)
                                }
                            }
                        }catch let err{
                            print(err)
                            
                            WebService.showAlert(err.localizedDescription)
                        }
                    }
                }
            }.resume()
        }
        else
        {
            self.showAlert(noInternetConnection)
        }
    }
    
    private static func errorShowAlert(_ message: String){
        DispatchQueue.main.async {
          //  CommonUtilities.shared.showAlert(message: message,isSuccess: .error)
        }
    }
    
    private static func showAlert(_ message: String){
        DispatchQueue.main.async {
          //  CommonUtilities.shared.showAlert(message: message,isSuccess: .success)
        }
    }
    
    
    private static func getString(from dict: Dictionary<String,Any>) -> String{
        var stringDict = String()
        stringDict.append("?")
        for (key, value) in dict{
            let param = key + "=" + "\(value)"
            stringDict.append(param)
            stringDict.append("&")
        }
        stringDict.removeLast()
        return stringDict
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8){
            append(data)
        }
    }
}

extension UIImage{
    func toData() -> Data{
        return self.jpegData(compressionQuality: 0.2)!
        
    }
    func isEqualToImage(image: UIImage) -> Bool
    {
        let data1: Data = self.pngData()!
        let data2: Data = image.pngData()!
        return data1 == data2
    }
}

struct ImageStructInfo {
    var fileName: String
    var type: String
    var data: Data
    var key:String
}

struct VideoStructInfo {
    var fileName: String
    var type: String
    var data: Data
    var key:String
    var image: UIImage
}

