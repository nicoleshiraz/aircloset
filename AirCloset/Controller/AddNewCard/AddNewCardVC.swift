//
//  AddNewCardVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit


class AddNewCardVC: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var cardHolderNameTxtFld: UITextField!
    @IBOutlet weak var cardNameTxtFld: UITextField!
    @IBOutlet weak var cardNumberTxtFld: UITextField!
    @IBOutlet weak var monthTxtFld: CustomTextField!
    @IBOutlet weak var yearTxtFld: CustomTextField!
    @IBOutlet weak var cvvTxtFld: UITextField!
    @IBOutlet weak var labelText: UILabel!
    //let datePicker = UIDatePicker()
    let stripeManager = StripeManager()
    var addnewCardVwModel = AddNewCardvwModel()
    
    //MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        //        showDatePicker()
        //        datePicker.minimumDate = Date()
    }
    
    
    //MARK: -  Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
        
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        if labelText.text == "" {
            if isTab == "AddMoney"{
                if  CheckValidation.checkAddNewCardData(holderName: cardHolderNameTxtFld.text ?? "", cardnumber: cardNumberTxtFld.text ?? "", expMonth: monthTxtFld.text ?? "", expYear: yearTxtFld.text ?? "", cvv: cvvTxtFld.text ?? ""){
                    stripeManager.createToken(cardNumber: cardNumberTxtFld.text ?? "", expMonth: UInt(Int(monthTxtFld.text ?? "") ?? 0), expYear: UInt(Int(yearTxtFld.text ?? "") ?? 0), cvc: cvvTxtFld.text ?? "") { [self] (token, error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                        } else if let token = token {
                            print("Token: \(token)")
                            // Use the token as needed
                            addnewCardVwModel.addNewCardApi(holderName: cardHolderNameTxtFld.text ?? "",cardNumber: (Int(cardNumberTxtFld.text ?? "") ?? 0), expMonth: (Int(monthTxtFld.text ?? "") ?? 0), expYear: (Int(yearTxtFld.text ?? "") ?? 0), cvv: (Int(cvvTxtFld.text ?? "") ?? 0),cardID: token)
                            addnewCardVwModel.onSuccess = { [weak self] in
                                self?.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            } else if isTab == "CheckOut"{
                if  CheckValidation.checkAddNewCardData(holderName: cardHolderNameTxtFld.text ?? "", cardnumber: cardNumberTxtFld.text ?? "", expMonth: monthTxtFld.text ?? "", expYear: yearTxtFld.text ?? "", cvv: cvvTxtFld.text ?? ""){
                    
                    stripeManager.createToken(cardNumber: cardNumberTxtFld.text ?? "", expMonth: UInt(Int(monthTxtFld.text ?? "") ?? 0), expYear: UInt(Int(yearTxtFld.text ?? "") ?? 0), cvc: cvvTxtFld.text ?? "") { [self] (token, error) in
                        if let error = error {
                            print("Error: \(error.localizedDescription)")
                            CommonUtilities.shared.showAlert(message: error.localizedDescription)
                        } else if let token = token {
                            print("Token: \(token)")
                            // Use the token as needed
                            addnewCardVwModel.addNewCardApi(holderName: cardHolderNameTxtFld.text ?? "",cardNumber: (Int(cardNumberTxtFld.text ?? "") ?? 0), expMonth: (Int(monthTxtFld.text ?? "") ?? 0), expYear: (Int(yearTxtFld.text ?? "") ?? 0), cvv: (Int(cvvTxtFld.text ?? "") ?? 0),cardID: token)
                            
                            addnewCardVwModel.onSuccess = { [weak self] in
                                self?.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }else{
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension AddNewCardVC:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        let updatedText = (text as NSString).replacingCharacters(in: range, with: string)
        
        if textField == monthTxtFld {
            if let month = Int(updatedText), (0...12).contains(month) {
                labelText.text = ""
                return true
            }
            else {
                monthTxtFld.text = (monthTxtFld.text ?? "") + string
                if Int(monthTxtFld.text ?? "") ?? 0 > 12 {
                }
                
                return true
            }
            
        }else if textField == yearTxtFld {
            if updatedText.count <= 4 {
                // Attempt to convert the text to an integer
                if let year = Int(updatedText) {
                    let currentYear = Calendar.current.component(.year, from: Date())
                    
                    if updatedText.count == 4{
                        if year >= currentYear {
                            
                            return true
                        } else{
                            return false
                        }
                    }else{
                        return true
                    }
                }
            }
        }
        return true
    }
}
