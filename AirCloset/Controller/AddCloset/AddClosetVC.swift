//
//  AddClosetVC.swift
//  AirCloset
//
//  Created by cql105 on 06/04/23.
//

import UIKit
import DropDown
import LocationPickerViewController

struct imageUpload{
    var image:UIImage
    
    init(image:UIImage) {
        self.image = image
    }
}

class AddClosetVC: UIViewController,UITextViewDelegate {
    
    //MARK: -> Outlets & Variables
    @IBOutlet weak var addClosetColVw: UICollectionView!
    @IBOutlet weak var addClosetTableVw: UITableView!
    @IBOutlet weak var addFacilitiesTblVw: UITableView!
    @IBOutlet weak var addClosetLbl: UILabel!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var descriptionTxtVw: UITextView!
    @IBOutlet weak var colorLbl: UILabel!
    @IBOutlet weak var styleLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var domesticOwnShingLbl: UILabel!
    var profileImage = UIImage()
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var videoPlacehldImg: UIImageView!
    
    var facilityObj : AllFacilities?
    var facilityObj2 : Facilities?
    var isSet = 0
    var selectedIndex = -1
    var showImage = ["Group 9417"]
    var closetTitleAry = ["Category","Brand","Size","Rent","Deposit"]
    var selectedImage : UIImage?
    
    var facilityArr = ["Dry-cleaning","Pick Up","Express Shipping"]
    var facilityImgArr = [(UIImage(named: "washing-machine")),(UIImage(named: "pickup")),(UIImage(named:"express-delivery"))]
    let dropDown = DropDown()
    var addPostCommnVwModel = AddPostVwModel()
    var imgArr : [UIImage] = []
    
    var selctedCataStr : String?
    var selectedBrandStr : String?
    var selectedSizeStr : String?
    var selctedConditionStr : String?
    var enteredRentStr : String?
    var enteredDepositStr : String?
    var finalArr = [UIImage]()
    var arrImageUpload = [imageUpload]()
    var selectedFaciliitiesArr : [Int] = []
    var lat = Double()
    var long = Double()
    
    var cataId : String?
    var brandId : String?
    var sizeId : String?
    var conditionId : String?
    
    var facilitesopt1:Int?
    var facilitesopt2:Int?
    var facilitesopt3:Int?
    var colorId : String?
    var styleId : String?
    var rent = 0
    var deposit = 0
    var shippinggg = 0
    var comesFrom = String()
    var imageInfo : ImageStructInfo?
    var videoUrl : URL?
    var addPostVwModel = AddPostVwModel()
    var vwModel = ProductVwModel()
    var productID = String()
    var type = String()
    var isVideoSelected = false
    var videoThumb : UIImageView?
    var isSelected = false
    var historyLocationList: [LocationItem] {
        get {
            if let locationDataList = UserDefaults.standard.array(forKey: "HistoryLocationList") as? [Data] {
                // Decode NSData into LocationItem object.
                return locationDataList.map({ NSKeyedUnarchiver.unarchiveObject(with: $0) as! LocationItem })
            } else {
                return []
            }
        }
        set {
            // Encode LocationItem object.
            let locationDataList = newValue.map({ NSKeyedArchiver.archivedData(withRootObject: $0) })
            UserDefaults.standard.set(locationDataList, forKey: "HistoryLocationList")
        }
    }
    
    //MARK: -> View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        type = "1"
        domesticOwnShingLbl.text = ""
        locationLbl.text = ""
        descriptionTxtVw.text = ""
        
        let obj = AllFacilities(pickup: 0, drycleaning: 0, deleivery: 0)
        self.facilityObj = obj
        descriptionTxtVw.delegate = self
        addClosetColVw.delegate = self
        addClosetColVw.dataSource = self
        addClosetTableVw.delegate = self
        addClosetTableVw.dataSource = self
        
        if isSet == 0 {
            addClosetLbl.text = "Add to Closet"
            postBtn.setTitle("Post", for: .normal)
        } else if isSet == 1{
            addClosetLbl.text = "Edit Closet"
            setData()
            type = "2"
            postBtn.setTitle("Update", for: .normal)
        }
        
        for i in 0..<imgArr.count {
            let obj = imageUpload(image: imgArr[i])
            arrImageUpload.append(obj)
        }
    }
    
    //MARK: Set Edit Data
    
    func setData() {
        vwModel.getProductDetailApi(id: productID)
        vwModel.onSuccess = { [self] in
            type = "1"
            locationLbl.text = self.vwModel.productDetailInfo?.body?.location ?? ""
            descriptionTxtVw.text = self.vwModel.productDetailInfo?.body?.description ?? ""
            colorLbl.text = self.vwModel.productDetailInfo?.body?.colorID?.name ?? ""
            if colorLbl.text == "" {
                colorLbl.text = "Color"
            }
            colorId = self.vwModel.productDetailInfo?.body?.colorID?.id ?? ""
            styleLbl.text = self.vwModel.productDetailInfo?.body?.styleID?.name ?? ""
            if styleLbl.text == "" {
                styleLbl.text = "Style"
            }
            self.nameTxtFld.text = self.vwModel.productDetailInfo?.body?.name ?? ""
            styleId = self.vwModel.productDetailInfo?.body?.styleID?.id
            selctedCataStr = self.vwModel.productDetailInfo?.body?.categoryID?.name ?? ""
            self.cataId = self.vwModel.productDetailInfo?.body?.categoryID?.id
            selectedBrandStr = self.vwModel.productDetailInfo?.body?.brandID?.name ?? ""
            self.brandId = self.vwModel.productDetailInfo?.body?.brandID?.id
            selectedSizeStr = self.vwModel.productDetailInfo?.body?.sizeID?.name ?? ""
            self.sizeId = self.vwModel.productDetailInfo?.body?.sizeID?.id
            selctedConditionStr = self.vwModel.productDetailInfo?.body?.conditionID?.name ?? ""
            self.conditionId = self.vwModel.productDetailInfo?.body?.conditionID?.id
            deposit = self.vwModel.productDetailInfo?.body?.deposit ?? 0
            rent = self.vwModel.productDetailInfo?.body?.price ?? 0
            enteredRentStr = "\(self.vwModel.productDetailInfo?.body?.price ?? 0)"
            enteredDepositStr = "\(self.vwModel.productDetailInfo?.body?.deposit ?? 0)"
            shippinggg = self.vwModel.productDetailInfo?.body?.shipping ?? 0
            domesticOwnShingLbl.text = "\(self.vwModel.productDetailInfo?.body?.shipping ?? 0)"
            facilityObj?.deleivery = self.vwModel.productDetailInfo?.body?.facilities?.deleivery
            facilityObj?.pickup = self.vwModel.productDetailInfo?.body?.facilities?.pickup
            facilityObj?.drycleaning = self.vwModel.productDetailInfo?.body?.facilities?.drycleaning
            Singletone.shared.clothsTermsAndCon = self.vwModel.productDetailInfo?.body?.termAddCondition
            self.lat = Double(self.vwModel.productDetailInfo?.body?.lat ?? "") ?? 0.0
            self.long = Double(self.vwModel.productDetailInfo?.body?.long ?? "") ?? 0.0
            if facilityObj?.drycleaning == 1 {
                selectedFaciliitiesArr.insert(0, at: 0)
            } else {
                selectedFaciliitiesArr.insert(5, at: 0)
            }
            if facilityObj?.pickup == 1 {
                isSelected = true
                selectedFaciliitiesArr.insert(1, at: 1)
            }else {
                selectedFaciliitiesArr.insert(5, at: 1)
            }
            if facilityObj?.deleivery == 1 {
                isSelected = true
                selectedFaciliitiesArr.insert(2, at: 2)
            }else {
                selectedFaciliitiesArr.insert(5, at: 2)
            }
            addFacilitiesTblVw.reloadData()
            addClosetTableVw.reloadData()
            if self.vwModel.productDetailInfo?.body?.video != "" {
                self.isVideoSelected = true
                let videoURL = URL(string: "\(videoURLS)\(self.vwModel.productDetailInfo?.body?.video ?? "")")!
                self.videoUrl = URL(string: "\(videoURLS)\(self.vwModel.productDetailInfo?.body?.video ?? "")") ?? URL(string: "")
                if let url = videoUrl {
                    DispatchQueue.background {
                        do {
                            var videoData = Data()
                            videoData = try Data(contentsOf: url as URL)
                            self.imageInfo = ImageStructInfo.init(fileName: "video.mp4", type: "video/mp4", data:videoData , key: "video")
                        } catch let error {
                            print(error)
                        }
                    }
                }
                
                getThumbnail(from: videoURL) { thumbnailImage in
                    if let thumbnailImage = thumbnailImage {
                        DispatchQueue.main.async {
                            self.videoThumb?.image = thumbnailImage
                            self.videoPlacehldImg.image = thumbnailImage
                            self.profileImage = thumbnailImage
                            self.isVideoSelected = true
                        }
                    } else {
                    }
                }
            }
            
            arrImageUpload.removeAll()
            var allImgurls = [URL]()
            for obj in self.vwModel.productDetailInfo?.body?.image ?? [] {
                allImgurls.append(URL(string: "\(productImageUrl)\(obj)") ?? URL(fileURLWithPath: ""))
            }
            fetchImages(from: allImgurls) { images in
                for img in images {
                    self.arrImageUpload.append(imageUpload(image: img ?? UIImage()))
                    DispatchQueue.main.async {
                        self.addClosetColVw.reloadData()
                    }
                }
            }
        }
    }
    
    func downloadVideoData(from url: URL) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading video data: \(error)")
                return
            }
            
            if let videoData = data {
                // Process the downloaded video data here
                self.handleDownloadedVideoData(videoData)
            }
        }
        task.resume()
    }
    
    func handleDownloadedVideoData(_ data: Data) {
           // You can use the downloaded data here, for example, save it to a file, display it in a player, etc.
       }
    
    
    func fetchData(from url: URL, completion: @escaping (Data?, Error?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(nil, error)
            } else {
                completion(data, nil)
            }
        }
        task.resume()
    }
    
    //MARK: -> Custom Function DropDown
    @objc func deleteImgBtnTapped(sender : UIButton){
        arrImageUpload.remove(at: sender.tag)
        addClosetColVw.reloadData()
    }
    
    func dropDown(rowNo : Int){
        
        if rowNo == 0{
            dropDown.anchorView = addClosetTableVw.cellForRow(at: IndexPath(row: 0, section: 0))
            dropDown.bottomOffset = CGPoint(x: 0, y: addClosetTableVw.rowHeight  + 40)
            dropDown.direction = .bottom
            let ids = self.addPostCommnVwModel.catagoryInfo?.body?.compactMap { $0.id } ?? []
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                selctedCataStr = item
                self.cataId = ids[index]
                addClosetTableVw.reloadData()
            }
        }
        else if rowNo == 1 {
            dropDown.anchorView = addClosetTableVw.cellForRow(at: IndexPath(row: rowNo, section: 0))
            dropDown.bottomOffset = CGPoint(x: 0, y: addClosetTableVw.rowHeight  + 40)
            dropDown.direction = .bottom
            let ids = self.addPostCommnVwModel.brandInfo?.body?.compactMap { $0.id } ?? []
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                selectedBrandStr = item
                self.brandId = ids[index]
                addClosetTableVw.reloadData()
            }
        }
        else if rowNo == 2 {
            dropDown.anchorView = addClosetTableVw.cellForRow(at: IndexPath(row: rowNo, section: 0))
            dropDown.bottomOffset = CGPoint(x: 0, y: addClosetTableVw.rowHeight  + 40)
            dropDown.direction = .bottom
            let ids = self.addPostCommnVwModel.sizeInfo?.body?.compactMap { $0.id } ?? []
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                selectedSizeStr = item
                
                self.sizeId = ids[index]
                addClosetTableVw.reloadData()
            }
        }
        
        else if rowNo == 3 {
            dropDown.anchorView = addClosetTableVw.cellForRow(at: IndexPath(row: rowNo, section: 0))
            dropDown.bottomOffset = CGPoint(x: 0, y: addClosetTableVw.rowHeight  + 40)
            dropDown.direction = .bottom
            let ids = self.addPostCommnVwModel.conditionInfo?.body?.compactMap { $0.id } ?? []
            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                selctedConditionStr = item
                self.conditionId = ids[index]
                addClosetTableVw.reloadData()
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let rangeOfTextToReplace = Range(range, in: textView.text) else {
            return false
        }
        let substringToReplace = textView.text[rangeOfTextToReplace]
        let count = textView.text.count - substringToReplace.count + text.count
        return count <= 500
    }
    
    
    func showAlertWithTextField(title : String,placeholderTxt : String, alertNo : Int, ammount: Int) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            let heightConstraint = NSLayoutConstraint(item: textField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 25)
            textField.addConstraint(heightConstraint)
            textField.keyboardType = .numberPad
            textField.placeholder = placeholderTxt
            if alertNo == 1 {
                if self.rent == 0 {
                    textField.text = ""
                    self.enteredRentStr = "$\(self.rent)/Night"
                } else {
                    textField.text = "\(self.rent)"
                    self.enteredRentStr = "$\(self.rent)/Night"
                }
                
            } else if alertNo == 2 {
                if self.deposit == 0 {
                    textField.text = ""
                    self.domesticOwnShingLbl.text = "$\(self.deposit)"
                } else {
                    textField.text = "\(self.deposit)"
                    self.domesticOwnShingLbl.text = "$\(self.deposit)"
                }
            }
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            if let textField = alertController.textFields?.first {
                if let text = textField.text {
                    if text.isBlank == false{
                        if let enteredAmount = Int(text) {
                            if alertNo == 1 {
                                self.enteredRentStr = "$\(text)/Night"
                                self.rent = enteredAmount
                            } else if alertNo == 2 {
                                if self.rent == 0{
                                    CommonUtilities.shared.showSwiftAlert(message: "Please enter rent amount First", isSuccess: .error)
                                } else  if enteredAmount < self.rent {
                                    self.enteredDepositStr = "$" + text
                                    self.deposit = enteredAmount
                                } else {
                                    CommonUtilities.shared.showSwiftAlert(message: "The Deposit amount should not be greater than Rent Amount", isSuccess: .error)
                                }
                            } else {
                                self.domesticOwnShingLbl.text = "$" + text
                                self.shippinggg = enteredAmount
                            }
                        } else {
                            CommonUtilities.shared.showSwiftAlert(message: "Invalid input. Please enter a valid amount.", isSuccess: .error)
                        }
                    }
                }
            }
            self.addClosetTableVw.reloadData()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - API Functions
    func getCataApi(onSucces:@escaping(()->())){
        addPostCommnVwModel.getCatagoryList {
            let dataSource = self.addPostCommnVwModel.catagoryInfo?.body?.compactMap { $0.name } ?? []
            print("data ======",dataSource)
            self.dropDown.dataSource = dataSource
            self.dropDown.show()
            onSucces()
        }
    }
    
    func getBrandApi(onSucces:@escaping(()->())){
        addPostCommnVwModel.getBrandListApi {
            let dataSource = self.addPostCommnVwModel.brandInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSource
            self.dropDown.show()
            onSucces()
        }
    }
    
    func getSizeApi(onSucces:@escaping(()->())){
        addPostCommnVwModel.getSizeListApi {
            let dataSource = self.addPostCommnVwModel.sizeInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSource
            self.dropDown.show()
            onSucces()
        }
    }
    
    
//    func getConditionApi(onSucces:@escaping(()->())){
//        addPostCommnVwModel.getConditionList {
//            let dataSource = self.addPostCommnVwModel.conditionInfo?.body?.compactMap { $0.name } ?? []
//            self.dropDown.dataSource = dataSource
//            self.dropDown.show()
//            onSucces()
//        }
//    }
    
    func getColorApi(onSucces:@escaping(()->())){
        addPostCommnVwModel.getColorListApi {
            let dataSouce = self.addPostCommnVwModel.colorInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSouce
            self.dropDown.direction = .bottom
            self.dropDown.show()
            let ids = self.addPostCommnVwModel.colorInfo?.body?.compactMap { $0.id } ?? []
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                colorId = ids[index]
                colorLbl.text = item
                
            }
            onSucces()
        }
    }
    
    func getStyleApi(onSucces:@escaping(()->())){
        addPostCommnVwModel.getStyleListApi {
            let dataSouce = self.addPostCommnVwModel.styleInfo?.body?.compactMap { $0.name } ?? []
            self.dropDown.dataSource = dataSouce
            self.dropDown.direction = .bottom
            self.dropDown.show()
            let ids = self.addPostCommnVwModel.styleInfo?.body?.compactMap { $0.id } ?? []
            self.dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
                styleLbl.text = item
                styleId  = ids[index]
                
            }
            onSucces()
        }
    }
    
    
    
    //MARK: - IBAction
    @IBAction func tapBackBtn(_ sender: UIButton) {
        Singletone.shared.clothsTermsAndCon = nil
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadVideoBtnTapped(_ sender: UIButton) {
        
        imagePickerSources.initialize()
        imagePickerSources.showOnlyVideoPicker()
        imagePickerSources.pathUrl = { linkUrl in
            self.videoUrl = linkUrl
        }
        imagePickerSources.pickImageCallback = { image in
            self.imageInfo = image
            let thumbimage = createThumbnailOfVideoFromFileURL(videoURL: self.videoUrl!)
            self.videoPlacehldImg.image = thumbimage
            self.videoThumb?.image = thumbimage
            self.isVideoSelected = true
            self.profileImage = thumbimage!
        }
    }
    
    
    @IBAction func addTermAndCondBtnTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsConditionsVC") as! TermsConditionsVC
        vc.type = "post"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func colorBtnTapped(_ sender: UIButton) {
        getColorApi{
            self.dropDown.anchorView = sender
            self.dropDown.bottomOffset = CGPoint(x: 0, y: 30)
        }
    }
    
    @IBAction func styleBtnTapped(_ sender: UIButton) {
        getStyleApi{
            self.dropDown.anchorView = sender
            self.dropDown.bottomOffset = CGPoint(x: 0, y: 30)
        }
        
    }
    
    @IBAction func domesticShipngBtnTapped(_ sender: UIButton) {
        showAlertWithTextField(title: "Enter price", placeholderTxt: "Enter shipping price", alertNo: 3, ammount: shippinggg)
        
    }
    
    @IBAction func locationBtnTapped(_ sender: UIButton) {
        let customLocationPicker = CustomLocationAddProducts()
        customLocationPicker.viewController = self
        let navigationController = UINavigationController(rootViewController: customLocationPicker)
        present(navigationController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func tapPostBtn(_ sender: UIButton) {
                
        if isTab == "Explore" {
            
            if let url = videoUrl {
                DispatchQueue.background {
                    do {
                        var videoData = Data()
                        videoData = try Data(contentsOf: url as URL)
                        self.imageInfo = ImageStructInfo.init(fileName: "video.mp4", type: "video/mp4", data:videoData , key: "video")
                    } catch let error {
                        print(error)
                    }
                }
            }
            
            finalArr.removeAll()
            for i in 0..<arrImageUpload.count {
                
                if (!arrImageUpload[i].image.isEqualToImage(image:UIImage(named: "Rectangle 17779")!)) {
                    
                    self.finalArr.append(arrImageUpload[i].image)
                }
            }
            
            if comesFrom == "Edit" {
                type = "2"
            }
            let imageViews = finalArr.map { UIImageView(image: $0) }
            if CheckValidation.checkCreateProductData(image: imageViews, description: descriptionTxtVw.text ?? "", categoryId: cataId ?? "", brandId: brandId ?? "", sizeId: sizeId ?? "", conditionId: "2121", price: rent , deposit: deposit, colorId: colorId ?? "", styleId: styleId ?? "", shipping: shippinggg, locationName: locationLbl.text ?? "",name: nameTxtFld.text ?? "",  facilities: isSelected) {
                
                if self.isVideoSelected == true {
                    let getImage = getImageData(selectedImage: profileImage,key: "thumbnail")
                    addPostVwModel.addPostApi(image: imageViews, video: self.imageInfo ?? ImageStructInfo(fileName: "", type: "", data: Data(), key: ""), description: descriptionTxtVw.text ?? "", categoryId: cataId ?? "", brandId: brandId ?? "", sizeId: sizeId ?? "", conditionId: conditionId ?? "", price: rent, deposit: deposit , colorId: colorId ?? "", styleId: styleId ?? "", facilities: facilityObj ?? AllFacilities(), shipping: shippinggg, location: locationLbl.text ?? "" , lat : "\(lat)" ,long : "\(long)",id: productID, type: type, thumbnaill: getImage,name: nameTxtFld.text ?? "")
                    addPostVwModel.onSuccess = { [weak self] in
                        Singletone.shared.clothsTermsAndCon = nil
                        CommonUtilities.shared.showSwiftAlert(message: "Product added successfully", isSuccess: .success)
                        if self?.comesFrom == "Edit" {
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                            vc.selectedIndex = 4
                            callBackMyCloset?()
                            self?.navigationController?.pushViewController(vc, animated: false)
                        } else {
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                            vc.selectedIndex = 0
                            self?.navigationController?.pushViewController(vc, animated: false)
                        }
                    }
                } else {
                    addPostVwModel.addPostApiWithoutVideo(image: imageViews, description: descriptionTxtVw.text ?? "", termAndCondition: Singletone.shared.clothsTermsAndCon ?? "", categoryId: cataId ?? "", brandId: brandId ?? "", sizeId: sizeId ?? "", conditionId: conditionId ?? "", price: rent, deposit: deposit , colorId: colorId ?? "", styleId: styleId ?? "", facilities: facilityObj ?? AllFacilities(), shipping: shippinggg, location: locationLbl.text ?? "" , lat : "\(lat)" ,long : "\(long)",id: productID, type: type,name: nameTxtFld.text ?? "")
                    addPostVwModel.onSuccess = { [weak self] in
                        Singletone.shared.clothsTermsAndCon = nil
                        CommonUtilities.shared.showSwiftAlert(message: "Product added successfully", isSuccess: .success)
                        if self?.comesFrom == "Edit" {
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                            vc.selectedIndex = 4
                            callBackMyCloset?()
                            self?.navigationController?.pushViewController(vc, animated: false)
                        } else {
                            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
                            vc.selectedIndex = 0
                            self?.navigationController?.pushViewController(vc, animated: false)
                        }
                    }
                }
            }
        }
        else if isTab == "MyClosetZeroIndex" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            vc.selectedIndex = 4
            isSet = 1
            self.navigationController?.pushViewController(vc, animated: false)
        } else {
            self.navigationController?.popViewController(animated: false)
        }
    }
}

//MARK: - CollectionView
extension AddClosetVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (arrImageUpload.count) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = addClosetColVw.dequeueReusableCell(withReuseIdentifier: "AddClosetCVCell", for: indexPath) as! AddClosetCVCell
        if indexPath.row == 0{
            cell.addClosetImageVw.image = UIImage(named: showImage[indexPath.row])
            cell.deleteBtn.isHidden = true
            cell.addClosetImageVw.layer.cornerRadius = 10
        }else{
            let image = arrImageUpload[indexPath.row - 1].image
            cell.addClosetImageVw.image = image
            cell.deleteBtn.tag = indexPath.row - 1
            cell.deleteBtn.isHidden = false
            cell.addClosetImageVw.layer.cornerRadius = 10
            cell.deleteBtn.addTarget(self, action: #selector(deleteImgBtnTapped(sender:)), for: .touchUpInside)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            ImagePickerManager().pickImage(self) { image in
                self.arrImageUpload.append(imageUpload(image: image))
                self.addClosetColVw.reloadData()
            }
        }
    }
}

//MARK: -  DelegatesDataSources of Table View
extension AddClosetVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == addClosetTableVw{
            return closetTitleAry.count
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addClosetTableVw{
            let cell = addClosetTableVw.dequeueReusableCell(withIdentifier: "AddClosetTVCell", for: indexPath) as! AddClosetTVCell
            cell.categoryLbl.text = closetTitleAry[indexPath.row]
            
            if indexPath.row == 0{
                cell.desLbl.text = selctedCataStr
            }
            else if indexPath.row == 1{
                cell.desLbl.text = selectedBrandStr
            }
            else if indexPath.row == 2{
                cell.desLbl.text = selectedSizeStr
            }
            else if indexPath.row == 3{
                cell.desLbl.text = enteredRentStr
            }
            else {
                cell.desLbl.text = enteredDepositStr
            }
            return cell
        }
        else{
            let cell = addFacilitiesTblVw.dequeueReusableCell(withIdentifier: "AddFacilitiesTVC", for: indexPath) as! AddFacilitiesTVC
            cell.facilityLbl.text = facilityArr[indexPath.row]
            cell.facilityImg.image = facilityImgArr[indexPath.row]
            if indexPath.row == 2{
                addFacilitiesTblVw.separatorColor = .clear
            }
            
//            if selectedFaciliitiesArr[indexPath.row] == 1{
//                cell.grayCheckCircleImg.image = UIImage(named: "pinkCheckCircle")
//            } else {
//                cell.grayCheckCircleImg.image = UIImage(named: "greyCheckCircle")
//            }
            if selectedFaciliitiesArr.contains(indexPath.row){
                cell.grayCheckCircleImg.image = UIImage(named: "pinkCheckCircle")
            }
            else {
                cell.grayCheckCircleImg.image = UIImage(named: "greyCheckCircle")
            }
            
            return cell
        }
    }
    
    //MARK: - DidSelect
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == addClosetTableVw {
            if indexPath.row == 0 {
                getCataApi {
                    self.dropDown(rowNo: indexPath.row)
                }
            }
            else if indexPath.row == 1{
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "BrandVC") as! BrandVC
                vc.callBack = { [self] (name, id) in
                    if name != "" && id != "" {
                        selectedBrandStr = name
                        brandId = id
                        addClosetTableVw.reloadData()
                    }
                }
                self.navigationController?.present(vc, animated: true)
            }
            else if indexPath.row == 2{
                
                getSizeApi{
                    self.dropDown(rowNo: indexPath.row)
                }
            }
            else if indexPath.row == 3{
                showAlertWithTextField(title: "Enter Rent", placeholderTxt: "Enter rent price", alertNo: 1, ammount: rent)
            }
            else {
                showAlertWithTextField(title: "Enter Deposit", placeholderTxt: "Enter deposit price", alertNo: 2, ammount: deposit)
            }
        }
        else {
            
            if indexPath.row == 0 {
                if facilityObj?.drycleaning == 0 {
                    self.facilityObj?.drycleaning = 1
                } else {
                    facilityObj?.drycleaning = 0
                }
            }
            else if indexPath.row == 1{
                if facilityObj?.pickup == 0 {
                    self.facilityObj?.pickup = 1
                    isSelected = true
                } else {
                    facilityObj?.pickup = 0
                }
            }
            else if indexPath.row == 2 {
                if facilityObj?.deleivery == 0 {
                    self.facilityObj?.deleivery = 1
                    isSelected = true
                } else {
                    facilityObj?.deleivery = 0
                }
            }
            if selectedFaciliitiesArr.contains(indexPath.row){
                selectedFaciliitiesArr = selectedFaciliitiesArr.filter({$0 != indexPath.row})
            } else {
                selectedFaciliitiesArr.append(indexPath.row)
            }
            print(selectedFaciliitiesArr)
            addFacilitiesTblVw.reloadData()
        }
        
    }
}

//Mark:--> Extension for Dashed Border
extension UIView {
    func addDashedBorder() {
        let color = UIColor.lightGray.cgColor
        
        let shapeLayer:CAShapeLayer = CAShapeLayer()
        let frameSize = self.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        shapeLayer.bounds = shapeRect
        shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineWidth = 0.5
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineDashPattern = [6,3]
        shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath
        self.layer.addSublayer(shapeLayer)
    }
}
//MARK: - Location
extension AddClosetVC: LocationPickerDelegate, LocationPickerDataSource {
    func numberOfAlternativeLocations() -> Int {
        return historyLocationList.count
        
    }
    
    func alternativeLocation(at index: Int) -> LocationItem {
        return historyLocationList.reversed()[index]
        
    }
    
    func showLocation(locationItem: LocationItem) {
        lat = locationItem.coordinate?.latitude ?? 0.0
        long = locationItem.coordinate?.longitude ?? 0.0
        print(lat)
        print(long)
        locationLbl.text = locationItem.name + "," + locationItem.formattedAddressString!
        
    }
    
    func storeLocation(locationItem: LocationItem) {
        if let index = historyLocationList.firstIndex(of: locationItem) {
            historyLocationList.remove(at: index)
        }
        historyLocationList.append(locationItem)
    }
    
    func locationDidSelect(locationItem: LocationItem) {
        print("Select delegate method: " + locationItem.name)
    }
    
    func locationDidPick(locationItem: LocationItem) {
        showLocation(locationItem: locationItem)
        storeLocation(locationItem: locationItem)
    }
    func convertToUTC(dateToConvert:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let convertedDate = formatter.date(from: dateToConvert)
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: convertedDate!)
        
    }
    
}

import UIKit
import LocationPickerViewController

class CustomLocationAddProducts: LocationPicker {
    
    var viewController: AddClosetVC!
    
    override func viewDidLoad() {
        super.addBarButtons()
        super.viewDidLoad()
    }
    
    @objc override func locationDidSelect(locationItem: LocationItem) {
        print("Select overrided method: " + locationItem.name)
        
    }
    
    @objc override func locationDidPick(locationItem: LocationItem) {
        viewController.showLocation(locationItem: locationItem)
        viewController.storeLocation(locationItem: locationItem)
    }
    
}
