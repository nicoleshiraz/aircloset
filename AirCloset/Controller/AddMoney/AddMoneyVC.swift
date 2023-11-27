//
//  AddMoneyVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit

class AddMoneyVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var addView: CustomView!
    @IBOutlet weak var ammountTxtFld: UITextField!
    @IBOutlet weak var addMoneyTableVw: UITableView!
    @IBOutlet weak var continueBtn: UIButton!
    
    var callBack: (()->())?
    var indexValue = -1
    var addMoneyVM = WithdrawVM()
    var selectedCard = String()
    var cardListVwModel = AddNewCardvwModel()
    var getCardListModel : GetCardListDetailModel?
    var addMoneyCardLbl = ["XXXX-XXXX-XXXX-1234","Credit or Debit Card","Paypal","Apple Pay"]
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMoneyTableVw.delegate = self
        addMoneyTableVw.dataSource = self
        ammountTxtFld.keyboardType = .numberPad
        continueBtn.isUserInteractionEnabled = true
        getCardList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCardList()
    }
    
    
    //MARK: - Custom Api Func
    func getCardList(){
        cardListVwModel.getCardListDetailApi()
        cardListVwModel.onSuccess = { [weak self] in
            self?.getCardListModel = self?.cardListVwModel.cardListInfo
            self?.addView.isHidden = self?.getCardListModel?.body?.count ?? 0 > 0 ? false : true
            self?.addMoneyTableVw.reloadData()
        }
    }
    
    //MARK: -> Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapContinueBtn(_ sender: UIButton) {
        
        if indexValue < 0 {
            CommonUtilities.shared.showSwiftAlert(message: "Please select card.", isSuccess: .error)
        } else if ammountTxtFld.text == "" {
            CommonUtilities.shared.showSwiftAlert(message: "Please add ammount.", isSuccess: .error)
        } else {
            addMoney(addParam: ["cardStripeId" : selectedCard , "amount": ammountTxtFld.text ?? ""])
        }
    }
    
    @IBAction func tapAddNewCardBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddNewCardVC") as! AddNewCardVC
        isTab = "AddMoney"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: -> DelegatesDataSources

extension AddMoneyVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        addMoneyTableVw.setEmptyData(msg: "No card added.", rowCount: getCardListModel?.body?.count ?? 0)
        return getCardListModel?.body?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addMoneyTableVw.dequeueReusableCell(withIdentifier: "AddMoneyTVC", for: indexPath) as! AddMoneyTVC
        cell.cardLbl.text =  "XXXX-XXXX-XXXX-\(getCardListModel?.body?[indexPath.row].number ?? 0)"
        if indexValue == indexPath.row{
            cell.circleImgVw.image = UIImage(named: "Icon awesome-check-circle")
        }else {
            cell.circleImgVw.image = UIImage(named: "Icon feather-circle")
        }
        cell.btnDelete.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(deleteCard(sender:)), for: .touchUpInside)
        return cell
    }
    
    @objc func deleteCard(sender: UIButton) {
        deleteCard(deleteParam: ["cardStripeId":getCardListModel?.body?[sender.tag].cardStripeID ?? ""])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        indexValue = indexPath.row
        selectedCard = getCardListModel?.body?[indexPath.row].cardStripeID ?? ""
        addMoneyTableVw.reloadData()
    }
}

//MARK: -> Extension Protocols

extension AddMoneyVC: TransactionProtocol {
    func removeTransactionPop(address: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WithdrawVC") as! WithdrawVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: -> Api Call

extension AddMoneyVC {
    
    private func addMoney(addParam: [String:Any]) {
        addMoneyVM.addMoney(params: addParam) { [weak self] in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TransactionPopUpVC") as! TransactionPopUpVC
            vc.transObj = self
            isTab = "Wallet"
            vc.ammount = self?.ammountTxtFld.text ?? ""
            vc.callBack = {
                self?.callBack?()
                self?.navigationController?.popViewController(animated: true)
            }
            self?.navigationController?.present(vc, animated: true)
        }
    }
    
    private func deleteCard(deleteParam: [String:Any]) {
        cardListVwModel.deleteProduct(params: deleteParam) {
            self.getCardList()
        }
    }
    
}
