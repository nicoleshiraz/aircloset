//
//  AddAccountVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit

class AddAccountVC: UIViewController {
    
    //MARK: -> Outlets
    
    @IBOutlet weak var ssnTxtFld: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var bankNameTxtFld: UITextField!
    @IBOutlet weak var accNumberTF: UITextField!
    @IBOutlet weak var confirmAccNoTF: UITextField!
    @IBOutlet weak var ifscCodeTxtFld: UITextField!
    
    var callBack: (()->())?
    var addbankVwModel = AddNewBankVwModel()
    var addVM = WithdrawVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: -> Actions
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapSaveBtn(_ sender: UIButton) {
        if CheckValidation.checkAddBankDetailData(accountHolderName: nameTF.text ?? "", bankName: bankNameTxtFld.text ?? "", accountNumber: accNumberTF.text ?? "", confirmAccNo: confirmAccNoTF.text ?? ""  , ifscCode: ifscCodeTxtFld.text ?? ""){
            addbankVwModel.addNewBankApi(accountHolderName: nameTF.text ?? "", bankName: bankNameTxtFld.text ?? "", accountNumber: accNumberTF.text ?? "", ifscCode: ifscCodeTxtFld.text ?? "")
            addbankVwModel.onSuccess = { [weak self] in
                self?.callBack?()
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}
