//
//  SavedAccVC.swift
//  AirCloset
//
//  Created by cqlnitin on 14/04/23.
//

import UIKit
import SwiftMessages

class SavedAccVC: UIViewController {
    
    //MARK: -> Outlets
    
    @IBOutlet weak var savedAccColVw: UICollectionView!
    @IBOutlet weak var withdrawView: CustomView!
    @IBOutlet weak var ammountTxtFld: UITextField!
    
    var totalAmmount = Double()
    var callBack: (()->())?
    var withdraw = WithdrawVM()
    var selectedBankDelete : String?
    var defaultSelectedbank : String?
    var accListData : GetBankListDetailModel?
    var getAccListVwmodel = AddNewBankVwModel()
    
    //MARK: -> View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savedAccColVw.delegate = self
        savedAccColVw.dataSource = self
        getBankList()
        ammountTxtFld.keyboardType = .numberPad
    }
    
    //MARK: - Custom API Func
    func getBankList(){
        getAccListVwmodel.getBankListDetailApi {
            self.accListData = self.getAccListVwmodel.bankListInfo
            self.withdrawView.isHidden = self.getAccListVwmodel.bankListInfo?.body?.count ?? 0 > 0 ? false : true
            self.savedAccColVw.reloadData()
        }
    }
    
    //MARK: -> Actions
    
    @IBAction func tapBackBtn(_ sender: UIButton) {
        callBack?()
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapWithdrawalBtn(_ sender: UIButton) {
        let withDrawAmmount = Double(ammountTxtFld.text ?? "")
        if ammountTxtFld.text == "" {
            CommonUtilities.shared.showSwiftAlert(message: "Please add amount to withdraw", isSuccess: .error)
        } else if withDrawAmmount ?? 0.0 > totalAmmount{
            CommonUtilities.shared.showSwiftAlert(message: "Withdraw ammount should not be greater then total ammount.", isSuccess: .error)
        } else {
            self.withdrawAmmount(withDrawParam: ["amount": self.ammountTxtFld.text ?? ""])
        }
    }
    
    @IBAction func tapAddNewBankBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddAccountVC") as! AddAccountVC
        vc.callBack = {
            self.getBankList()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: - Custom Func
    
    @objc func deleteBtnClicked(sender : UIButton){
        selectedBankDelete = accListData?.body?[sender.tag].stripeBankAccountID
        let vc = storyboard?.instantiateViewController(withIdentifier: "DeletePopUpVC") as! DeletePopUpVC
        vc.deleteObj = self
        self.navigationController?.present(vc, animated: true)
        
    }
}

//MARK: ->> DelegatesDataSources

extension SavedAccVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        savedAccColVw.setEmptyData(msg: "No bank account added.", rowCount: accListData?.body?.count ?? 0)
        return accListData?.body?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = savedAccColVw.dequeueReusableCell(withReuseIdentifier: "SavedAccCVC", for: indexPath) as! SavedAccCVC
        cell.accHolderNmlbl.text = accListData?.body?[indexPath.row].accountHolderName ?? ""
        cell.accNumberLbl.text = accListData?.body?[indexPath.row].accountNumber ?? ""
        cell.bankNameLbl.text = accListData?.body?[indexPath.row].accountHolderType ?? ""
        cell.deleteBtn.addTarget(self, action: #selector(deleteBtnClicked(sender:)), for: .touchUpInside)
        cell.deleteBtn.tag = indexPath.row
        if accListData?.body?[indexPath.row].isDefault == 1{
            cell.backView.isHidden = false
            cell.selectedImage.isHidden = false
        } else{
            cell.backView.isHidden = true

            cell.selectedImage.isHidden = true
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        getAccListVwmodel.setDefaultBankApi(stripeBankAccountId: accListData?.body?[indexPath.row].stripeBankAccountID ?? "" )
        getAccListVwmodel.onSuccess = { [weak self] in
            self?.getBankList()
        }
    }
    
}

//MARK: -> Extension Protocols
extension SavedAccVC: TransactionProtocol, DeleteProtocol{
    func removeDeletePop(address: Bool) {
        if address == true{
            getAccListVwmodel.deleteBankApi(stripeBankAccountId: selectedBankDelete ?? "")
            getAccListVwmodel.onSuccess = { [weak self] in
                self?.getBankList()
            }
        }
    }
    func removeTransactionPop(address: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "WithdrawVC") as! WithdrawVC
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

extension SavedAccVC {
    
    private func withdrawAmmount(withDrawParam: [String:Any]) {
        withdraw.withDrawAmmount(params: withDrawParam) { [weak self] in
            let vc = self?.storyboard?.instantiateViewController(withIdentifier: "TransactionPopUpVC") as! TransactionPopUpVC
            vc.transObj = self
            isTab = "Transaction"
            vc.callBack = {
                self?.callBack?()
                self?.navigationController?.popViewController(animated: true)
            }
            self?.navigationController?.present(vc, animated: true)
        }
    }
}
