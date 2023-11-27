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
    @IBOutlet weak var monthTxtFld: UITextField!
    @IBOutlet weak var yearTxtFld: UITextField!
    @IBOutlet weak var cvvTxtFld: UITextField!
    @IBOutlet weak var labelText: UILabel!
    //let datePicker = UIDatePicker()
    
    var addnewCardVwModel = AddNewCardvwModel()

    //MARK: - DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
//        showDatePicker()
//        datePicker.minimumDate = Date()
    }
//    //MARK: - Custom Func
//    func showDatePicker(){
//        //Formate Date
//        datePicker.datePickerMode = .date
//        if #available(iOS 14.0, *) {
//            datePicker.preferredDatePickerStyle = .wheels
//        } else {
//            // Fallback on earlier versions
//        }
//
//
//        //ToolBar
//        let toolbar = UIToolbar();
//        toolbar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
//        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
//        monthTxtFld.inputAccessoryView = toolbar
//        monthTxtFld.inputView = datePicker
//    }
    
//
//    @objc func donedatePicker(){
//        let formatter = DateFormatter()
//        let formatt = DateFormatter()
//    //    formatter.dateFormat = "dd.MM.yyyy"
//
//        formatter.dateFormat = "MM"
//        monthTxtFld.text = formatter.string(from: datePicker.date)
//
//        formatt.dateFormat = "yyyy"
//        yearTxtFld.text = formatt.string(from: datePicker.date)
//
//        self.view.endEditing(true)
//    }
    
//    @objc func cancelDatePicker(){
//        self.view.endEditing(true)
//    }
//
    
    
    //MARK: -  Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
//    @IBAction func circleBtnTapped(_ sender: UIButton) {
//        sender.isSelected = !sender.isSelected
//        if sender.isSelected {
//            defaultKey = 1
//        }
//        else {
//            defaultKey = 0
//        }
//
//    }
    
    
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        if labelText.text == "" {
            if isTab == "AddMoney"{
                if  CheckValidation.checkAddNewCardData(holderName: cardHolderNameTxtFld.text ?? "", cardnumber: cardNumberTxtFld.text ?? "", expMonth: monthTxtFld.text ?? "", expYear: yearTxtFld.text ?? "", cvv: cvvTxtFld.text ?? ""){
                    addnewCardVwModel.addNewCardApi(holderName: cardHolderNameTxtFld.text ?? "",cardNumber: (Int(cardNumberTxtFld.text ?? "") ?? 0), expMonth: (Int(monthTxtFld.text ?? "") ?? 0), expYear: (Int(yearTxtFld.text ?? "") ?? 0), cvv: (Int(cvvTxtFld.text ?? "") ?? 0))
                    addnewCardVwModel.onSuccess = { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            } else if isTab == "CheckOut"{
                if  CheckValidation.checkAddNewCardData(holderName: cardHolderNameTxtFld.text ?? "", cardnumber: cardNumberTxtFld.text ?? "", expMonth: monthTxtFld.text ?? "", expYear: yearTxtFld.text ?? "", cvv: cvvTxtFld.text ?? ""){
                    addnewCardVwModel.addNewCardApi(holderName: cardHolderNameTxtFld.text ?? "", cardNumber: (Int(cardNumberTxtFld.text ?? "") ?? 0), expMonth: (Int(monthTxtFld.text ?? "") ?? 0), expYear: (Int(yearTxtFld.text ?? "") ?? 0), cvv: (Int(cvvTxtFld.text ?? "") ?? 0))
                    addnewCardVwModel.onSuccess = { [weak self] in
                        self?.navigationController?.popViewController(animated: true)
                    }
                }
            }else{
                self.navigationController?.popViewController(animated: true)
                //            let vc = storyboard?.instantiateViewController(withIdentifier: "CheckOutVC") as! CheckOutVC
                //            self.navigationController?.pushViewController(vc, animated: false)
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
                   labelText.text = "Invalid Month"
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
