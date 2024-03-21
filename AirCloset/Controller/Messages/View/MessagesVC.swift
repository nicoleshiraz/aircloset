//
//  MessagesVC.swift
//  AirCloset
//
//  Created by cql105 on 31/03/23.
//

import UIKit
import SocketIO
import SwiftyJSON

class MessagesVC: UIViewController, UITextFieldDelegate {
    
//MARK: -> Outlets & Variables
    
    @IBOutlet weak var msgTableVw: UITableView!
    @IBOutlet weak var searchTxtFld: UITextField!
    
    var isFiltered = false
    var messageListArray = [RecieveAllUserChat]()
    var messageVM = MessageVM()
    var searchArray = [AllUser]()
    
    //MARK: ->  View Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        msgTableVw.delegate = self
        msgTableVw.dataSource = self
        self.searchTxtFld.delegate = self
        self.searchTxtFld.addTarget(self, action: #selector(searchWorkersAsPerText(_ :)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getList()
        getCount()
        updatesChats = { [self] in
            getList()
            getCount()

        }
    }
    
    //--------------------------------------------
    
    //MARK: Predicate to filter data
    
    @objc func searchWorkersAsPerText(_ textfield:UITextField) {
        isFiltered = true
        self.searchArray.removeAll()
        if searchTxtFld.text?.count != 0 {
            for obj in messageVM.userList {
                let range = obj.name?.lowercased().range(of: textfield.text!, options: .caseInsensitive, range: nil,   locale: nil)
                if range != nil {
                    searchArray.append(obj)
                }
                DispatchQueue.main.async {
                    self.msgTableVw.reloadData()
                }
            }
        } else {
            searchArray = messageVM.userList
            isFiltered = false
            DispatchQueue.main.async {
                self.msgTableVw.reloadData()
            }
        }
    }
    
}

// MARK: -> DelegateDataSources

extension MessagesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        msgTableVw.setEmptyData(msg: "No chat found.", rowCount: searchArray.count )
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = msgTableVw.dequeueReusableCell(withIdentifier: "MessageTVCell", for: indexPath) as! MessageTVCell
        let chatData = searchArray[indexPath.row]
        cell.msgTitleLbl.text = chatData.name
        cell.msgImgVw.roundedImage()
        cell.msgDescLbl.text = chatData.lastMessage?.data
        cell.msgTimeLbl.text = chatData.lastMessage?.date
        cell.msgImgVw.imageLoad(imageUrl: "\(imageURL)\(chatData.image ?? "")")
        if chatData.unreadCount ?? 0 > 0 {
            cell.countView.isHidden = false
        } else {
            cell.countView.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        vc.receiverId = searchArray[indexPath.row].receiverID ?? ""
        vc.checkBlockStatus = searchArray[indexPath.row].isBlocked ?? false
        vc.reciverName = searchArray[indexPath.row].name?.capitalizeFirstLetter() ?? ""
        vc.blockedMessage = searchArray[indexPath.row].blockedByMessage ?? ""
        vc.receiverImg = searchArray[indexPath.row].image ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: -> Get User List

extension MessagesVC {
    private func getList() {
        messageVM.fetchChatDialogs { [weak self] in
            self?.searchArray = self?.messageVM.userList ?? []
            self?.msgTableVw.reloadData()
        }
    }
    
    //MARK: - Count Emitter
    private func getCount(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.socketConnected(notification:)), name: Notification.Name("socketConnected"), object: nil)
        SocketIOManager.sharedInstance.countEmitter()
    }
    @objc func socketConnected(notification: Notification) {
        SocketIOManager.sharedInstance.countEmitter()
    }
    func connect() {
        SocketIOManager.sharedInstance.connectUser()
    }
    
}




