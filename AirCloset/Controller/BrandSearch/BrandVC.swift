//
//  BrandVC.swift
//  AirCloset
//
//  Created by cqlios3 on 14/09/23.
//

import UIKit
import Foundation

class BrandVC : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //------------------------------------------------------
    
    //MARK: Varibles and outlets
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblSearch: UITableView!
    
    var viewModel = BrandVM()
    var selectedIndex = -1
    var callBack: ((String,String)->())?
    var selectedID = String()
    var selectedBrandName = String()
    var searchArray = [BrandModelBody]()
    var isFiltered = false
    
    //------------------------------------------------------
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //------------------------------------------------------
    
    //MARK: Custome Function
    
    func setup() {
        getBrandData()
        self.txtSearch.addTarget(self, action: #selector(searchBrandWithName(_ :)), for: .editingChanged)
    }
    
    //--------------------------------------------
    
    //MARK: Predicate to filter data
    
    @objc func searchBrandWithName(_ textfield:UITextField) {
        isFiltered = true
        self.searchArray.removeAll()
        if txtSearch.text?.count != 0 {
            for obj in viewModel.brandData ?? [] {
                let range = obj.name?.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                if range != nil {
                    searchArray.append(obj)
                }
                DispatchQueue.main.async {
                    self.tblSearch.reloadData()
                }
            }
        } else {
            searchArray = viewModel.brandData ?? []
            isFiltered = false
            DispatchQueue.main.async {
                self.tblSearch.reloadData()
            }
        }
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action
    
    @IBAction func btnDone(_ sender: UIButton) {
        self.dismiss(animated: true) { [self] in
            callBack?(selectedBrandName, selectedID)
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true) { [self] in
            callBack?(selectedBrandName, selectedID)
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Table view delegate and datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        cell.lblBrand.text = searchArray[indexPath.row].name ?? ""
        if selectedIndex == indexPath.row {
            cell.imgChecked.image = UIImage(named: "checkmark")
        } else {
            cell.imgChecked.image = UIImage(named: "greyCheckCircle")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        selectedBrandName = searchArray[indexPath.row].name ?? ""
        selectedID = searchArray[indexPath.row].id ?? ""
        tblSearch.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    //------------------------------------------------------
    
    //MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    //------------------------------------------------------
}


class SearchCell: UITableViewCell {
    
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var lblBrand: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}


extension BrandVC {
    
    private func getBrandData() {
        viewModel.getBrands {
            self.searchArray = self.viewModel.brandData ?? []
            self.tblSearch.reloadData()
        }
    }
}
