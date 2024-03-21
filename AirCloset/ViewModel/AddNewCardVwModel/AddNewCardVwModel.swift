//
//  AddNewCardVwModel.swift
//  AirCloset
//
//  Created by cql200 on 08/06/23.
//

import Foundation

class AddNewCardvwModel : NSObject{
    
    var onSuccess : successResponse?
    var cardListInfo : GetCardListDetailModel?
    var defaultCardInfo : GetCardListDetailModelBody?
    var commonModelDATA : CommonModel?
    var reciptData: ReciptModelBody?
    var uploadData: UploadImageBody?
    var verificationData: VerificationModelBody?
    
    func addNewCardApi(holderName : String,cardNumber : Int,expMonth : Int, expYear : Int, cvv : Int , cardID: String){
        
        let param = ["cardName" : holderName,"number": cardNumber, "exp_month" : expMonth, "exp_year": expYear,"cvc" : cvv,"cardToken":cardID] as [String : Any]
        WebService.service(.addNewCard, param: param, service: .post, showHud: true) { (addCardData : AddNewCardModel, data,json ) in
            self.onSuccess?()
        }
    }
    
    func getCardListDetailApi(){
        
        let param = ["userId": Store.userDetails?.body?.id ?? ""]
        print(Store.userDetails?.body?.id ?? "")
        WebService.service(.cardListDetail, param: param, service: .post, showHud: true) { (cardListData : GetCardListDetailModel, data,json ) in
            self.cardListInfo = cardListData
            self.onSuccess?()
        }
    }
    
    func setDefaultcard(stripId : String,onSuccess:@escaping(()->Void)){
        
        let param = ["cardStripeId" : stripId]
        print(param)
        WebService.service(.setDefaultCard, param: param, service: .post, showHud: true) { (SingleCardData :GetCardListDetailModelBody , data,json ) in
            self.defaultCardInfo = SingleCardData
            print("Done")
           onSuccess()
        }
    }
    
    func payNowApi(amount : Int, cardId : String, productId : String ){
        
//        let param = ["amount" : amount,"cardId" : cardId,"productId" : productId] as [String : Any]
        
        let param = ["paymentMethod" : 0,"cardId" : cardId,"orderId" : productId] as [String : Any]        
        WebService.service(.payNow, param: param, service: .post, showHud: true) { (payNowDATA : CommonModel, data, json) in
            print(param)
            self.commonModelDATA = payNowDATA
            self.onSuccess?()
        }
    }
    
    func getRecipt(productId : String, onSuccessApi: @escaping (()->())){
        let param = ["orderId" : productId] as [String : Any]
        WebService.service(.getPaymentRecepe, param: param, service: .post, showHud: true) { (modelData : ReciptModel, data, json) in
            if let data = modelData.body {
                self.reciptData = data
            }
            onSuccessApi()
        }
    }
    
    func deleteProduct(params: [String:Any],onSuccessApi: @escaping(()->())) {
        WebService.service(.deleteCard ,param: params, service: .delete) { (modelData : CommonModel, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: modelData.message ?? "", isSuccess: .success)
            onSuccessApi()
        }
    }
    
    
    func idVerification(params: [String:Any],onSuccessApi: @escaping(()->())) {
        WebService.service(.idVerificationCreate ,param: params, service: .post) { (modelData : UploadImage, data, json) in
            CommonUtilities.shared.showSwiftAlert(message: "ID verification done.", isSuccess: .success)
            if let data = modelData.body {
                self.uploadData = data
                Store.userDetails?.body?.idVerification = 1
            }
            onSuccessApi()
        }
    }
    
    func idVerificationReturn(params: [String:Any],onSuccessApi: @escaping(()->())) {
        WebService.service(.uploadReturnProof ,param: params, service: .post) { (modelData : UploadImage, data, json) in
            if let data = modelData.body {
                self.uploadData = data
                Store.userDetails?.body?.idVerification = 1
            }
            onSuccessApi()
        }
    }
    
    func idVerificationDetails(onSuccessApi: @escaping(()->())) {
        WebService.service(.verificationData ,param: [:], service: .get) { (modelData : VerificationModel, data, json) in
            if let data = modelData.body {
                self.verificationData = data
            }
            onSuccessApi()
        }
    }
    
}

struct VerificationModel: Codable {
    var success: Bool?
    var code: Int?
    var message: String?
    var body: VerificationModelBody?
}

// MARK: - Body
struct VerificationModelBody: Codable {
    var id, image, userID, createdAt: String?
    var updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case image
        case userID = "userId"
        case createdAt, updatedAt
        case v = "__v"
    }
}


struct UploadImage: Codable {
    var success: Bool?
    var code: Int?
    var messsage: String?
    var body: UploadImageBody?
}

// MARK: - Body
struct UploadImageBody: Codable {
    var userID, id, createdAt, updatedAt: String?
    var v: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
