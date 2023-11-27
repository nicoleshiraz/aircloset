//
//  FilterVC.swift
//  AirCloset
//
//  Created by cql105 on 05/04/23.
//

import UIKit
import RangeSeekSlider
import DropDown
import CoreLocation

class FilterVC: UIViewController {
    
    // Mark :--> Outlets
    @IBOutlet weak var rangeSeekSliderVw: RangeSeekSlider!
    @IBOutlet weak var brandNameTxtFld: UITextField!
    @IBOutlet weak var colorTxtFld: UITextField!
    @IBOutlet weak var sizeTxtFld: UITextField!
    @IBOutlet weak var priceeTxtFld: UITextField!
    
    var brandId : String?
    var colorId : String?
    var sizeId : String?
    // var price : String?
    var min : Int?
    var max : Int?
    
    var brandName : String?
    var colorName : String?
    var sizeName : String?
    
    
    let dropDown = DropDown()
    var addPostCommnVwModel = AddPostVwModel()
    let locationManager = CLLocationManager()
    var latitude:Double?
    var longitude:Double?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rangeSeekSliderVw.selectedMinValue = CGFloat(Singletone.shared.minDistFilter ?? Int(0.0))
        rangeSeekSliderVw.selectedMaxValue = CGFloat(Singletone.shared.maxDistfilter ?? Int(100.0))
        brandNameTxtFld.text = Singletone.shared.brandName
        colorTxtFld.text = Singletone.shared.colorName
        sizeTxtFld.text = Singletone.shared.sizeName
        brandId = Singletone.shared.brandFilter
        brandName = Singletone.shared.brandName
        colorId = Singletone.shared.colorFilter
        colorName = Singletone.shared.colorName
        sizeId = Singletone.shared.sizeFilter
        sizeName = Singletone.shared.sizeName
        
        if let price = Singletone.shared.priceFiler {
            priceeTxtFld.text = String(describing: price)
        } else {
            priceeTxtFld.text = ""
        }
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        if CLLocationManager.locationServicesEnabled(){
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        }else{
            openSettings()
        }
    }
    
    func openSettings(){
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
        }
    }
    
    override func viewWillLayoutSubviews() {
        if !hasLocationPermission() {
            let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Settings", style: .default, handler: {(cAlertAction) in
                
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(cnclAction) in
                
                self.navigationController?.popViewController(animated: true)
            })
            alertController.addAction(cancelAction)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    
    
    //MARK: - Custom DropDown Func
    
    func dropdownn(setAnchor : UIButton){
        dropDown.anchorView = setAnchor
        dropDown.bottomOffset = CGPoint(x: 0, y: 50)
        self.dropDown.show()
        self.dropDown.direction = .bottom
        
    }
    
    //Mark :--> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapApplyBtn(_ sender: UIButton) {
        min = Int(rangeSeekSliderVw.selectedMinValue)
        max = Int(rangeSeekSliderVw.selectedMaxValue)
        Singletone.shared.brandFilter = brandId
        Singletone.shared.brandName = brandName
        Singletone.shared.colorFilter = colorId
        Singletone.shared.colorName = colorName
        Singletone.shared.sizeFilter = sizeId
        Singletone.shared.sizeName = sizeName
        Singletone.shared.priceFiler = Int(priceeTxtFld.text!)
        Singletone.shared.minDistFilter = min
        Singletone.shared.maxDistfilter = max
        callBackMyCloset?()
        self.navigationController?.popViewController(animated: true)
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
//        vc.selectedIndex = 0
//        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    @IBAction func brandBtnTapped(_ sender: UIButton) {
        
        addPostCommnVwModel.getBrandListApi {
            let dataSource = self.addPostCommnVwModel.brandInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSource
            self.dropdownn(setAnchor: sender)
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                brandId = self.addPostCommnVwModel.brandInfo?.body?[index].id
                brandNameTxtFld.text = item
                brandName = brandNameTxtFld.text
            }
        }
    }
    
    @IBAction func colorBtnTapped(_ sender: UIButton) {
        addPostCommnVwModel.getColorListApi {
            let dataSource = self.addPostCommnVwModel.colorInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSource
            self.dropdownn(setAnchor: sender)
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                colorTxtFld.text = item
                colorId = self.addPostCommnVwModel.colorInfo?.body?[index].id
                colorName = colorTxtFld.text
            }
        }
    }
    
    @IBAction func sizeBtnTapped(_ sender: UIButton) {
        addPostCommnVwModel.getSizeListApi {
            let dataSource = self.addPostCommnVwModel.sizeInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSource
            self.dropdownn(setAnchor: sender)
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                sizeTxtFld.text = item
                sizeId = self.addPostCommnVwModel.sizeInfo?.body?[index].id
                sizeName = sizeTxtFld.text
                //Singletone.shared.sizeName = sizeName
            }
        }
    }
    
    @IBAction func tapClearBtn(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: "select")
        brandNameTxtFld.text = ""
        colorTxtFld.text = ""
        sizeTxtFld.text = ""
        priceeTxtFld.text = ""
        rangeSeekSliderVw.selectedMaxValue = 0
        rangeSeekSliderVw.selectedMinValue = 0
        
        Singletone.shared.brandFilter = ""
        Singletone.shared.brandName = nil
        
        Singletone.shared.colorName = ""
        Singletone.shared.colorFilter = ""
        
        Singletone.shared.sizeName = ""
        Singletone.shared.sizeFilter = ""
        
        Singletone.shared.priceFiler = Int("")
        Singletone.shared.minDistFilter = 0
        Singletone.shared.maxDistfilter = 0
        
        rangeSeekSliderVw.layoutSubviews()
        
        brandId = ""
        colorId = ""
        sizeId = ""
        brandName = ""
        colorName = ""
        sizeName = ""
        
    }
    
}

extension FilterVC : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        Store.lat = location.coordinate.latitude
        Store.long = location.coordinate.longitude
        latitude = Store.lat
        longitude = Store.long
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location updates: \(error.localizedDescription)")
    }
    
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        
        if CLLocationManager.locationServicesEnabled() {
            if #available(iOS 14.0, *) {
                switch locationManager.authorizationStatus {
                case .notDetermined, .restricted, .denied:
                    hasPermission = false
                case .authorizedAlways, .authorizedWhenInUse:
                    hasPermission = true
                    //getArea()
                @unknown default:
                    break
                }
            } else {
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
}
