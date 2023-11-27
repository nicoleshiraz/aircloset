//
//  ChatVC.swift
//  AirCloset
//
//  Created by cql105 on 03/04/23.
//

import UIKit
import SwiftyJSON
import IQKeyboardManagerSwift

class ChatVC: UIViewController {
    
    //MARK: -> Outlets & Variables
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var blockerView: UIView!
    @IBOutlet weak var chatTableVw: UITableView!
    @IBOutlet weak var mainBlockVw: CustomView!
    @IBOutlet weak var viewBottom: NSLayoutConstraint!
    @IBOutlet weak var txtView: UITextField!
    @IBOutlet weak var blockLabel: UILabel!
    @IBOutlet weak var btnBlockOutlet: UIButton!
    
    var comes = String()
    var isClicked = Int()
    var selectTxt = Bool()
    var receiverId = String()
    var isFromSendMsg = false
    var receiverImg = String()
    var reciverName = String()
    var blockedMessage = String()
    var checkBlockStatus = Bool()
    var allMessage = [AllMessage]()
    var chatmessageList = [GetChatListElement]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        keyboardHandling()
        mainBlockVw.isHidden = true
        chatTableVw.delegate = self
        chatTableVw.dataSource = self
        blockLabel.text = blockedMessage
        userName.text = reciverName.capitalizeFirstLetter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchMessages()
        SocketIOManager.sharedInstance.newChat()
        keyboardHandling()
        isChatOpen = true
        activateListeners()
        blockerView.isHidden = true
        if checkBlockStatus == true {
            btnBlockOutlet.setTitle("Unblock", for: .normal)
        } else {
            btnBlockOutlet.setTitle("Block", for: .normal)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(self.socketConnected(notification:)), name: Notification.Name("socketConnected"), object: nil)
    }
 
    override func viewDidDisappear(_ animated: Bool) {
        isChatOpen = false
    }
    
    @objc func socketConnected(notification: Notification) {
        activateListeners()
    }
    
    // MARK: - KEYBOARD HANDLERS
    
    private func keyboardHandling(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.viewBottom.constant = 20
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.viewBottom.constant = (keyboardSize.height - self.view.safeAreaInsets.bottom + 10)
            self.view.layoutIfNeeded()
            self.view.setNeedsLayout()
            self.chatTableVw.scrollToBottom(animated: true)
        }
    }
    
    func connect() {
        SocketIOManager.sharedInstance.connectUser()
    }
    
    @objc private func keyboardWillChangeFrame(_ notification: Notification) {
        if selectTxt {
            if let endFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                var keyboardHeight = UIScreen.main.bounds.height - endFrame.origin.y
                if #available(iOS 11, *) {
                    if keyboardHeight > 0 {
                        keyboardHeight = keyboardHeight - view.safeAreaInsets.bottom
                    }
                }
                viewBottom.constant = keyboardHeight
                view.layoutIfNeeded()
            }
        }
    }
    
    @IBAction func btnSendMessageAction(_ sender: UIButton) {
        if txtView.text == "" {
            CommonUtilities.shared.showSwiftAlert(message: "Please type something", isSuccess: .error)
        } else {
            let msg = ["type":"text","data": self.txtView.text ?? ""]
            let param = ["receiverId":receiverId, "message":msg] as [String : Any]
            sendMessage(type: "text", msg: param)
            self.txtView.text = ""
            self.isFromSendMsg = true
        }
    }
    
    //MARK: -> Actions
    
    @IBAction func tapBackChatBtn(_ sender: UIButton) {
        if comes == "Notif" {
            let homeStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
            let vc = homeStoryboard.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
            let nav = UINavigationController.init(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.interactivePopGestureRecognizer?.isEnabled = false
            UIApplication.shared.windows.first?.rootViewController = nav
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func tapDotsBtn(_ sender: UIButton) {
        if isClicked == 0{
            mainBlockVw.isHidden = false
            isClicked = 1
        } else {
            mainBlockVw.isHidden = true
            isClicked = 0
        }
    }
    
    @IBAction func tapViewProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SellerProfileVC") as! SellerProfileVC
        vc.userID = receiverId
        vc.comesFrom = "Chat"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBlockBtn(_ sender: UIButton) {
        self.txtView.resignFirstResponder()
        if blockLabel.text == "You blocked by this user" {
            CommonUtilities.shared.showSwiftAlert(message: "\(reciverName) blocked you. You can't unblock from your side", isSuccess: .error)
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "BlockPopUpVC") as! BlockPopUpVC
            vc.blockObj = self
            vc.callBack = { (status) in
                if status == true {
                    self.blockUser {
                        self.fetchMessages()
                    }
                }
            }
            vc.blockStatus = checkBlockStatus
            vc.name = reciverName
            mainBlockVw.isHidden = true
            self.navigationController?.present(vc, animated: true)
        }
    }
    
    @IBAction func tapClearBtn(_ sender: UIButton) {
        clearChat()
        self.mainBlockVw.isHidden = true
    }
    
    @IBAction func tapReportUser(_ sender: UIButton) {
        self.txtView.resignFirstResponder()
        let vc = storyboard?.instantiateViewController(withIdentifier: "ReportPopUpVC") as! ReportPopUpVC
        vc.reportObj = self
        vc.callBack = { (status, message) in
            if status == true {
                self.reportUser(str: message)
            }
        }
        vc.name = reciverName
        mainBlockVw.isHidden = true
        self.navigationController?.present(vc, animated: true)
    }
}

//MARK: ->  Extension Protocols

extension ChatVC: BlockProtocol, ReportProtocol {
    func removeReportPop(address: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 1
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func removeBlockPop(address: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") as! TabBarVC
        vc.selectedIndex = 1
        self.navigationController?.pushViewController(vc, animated: false)
    }
}

//MARK: ->  DelegatesDatasources

extension ChatVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatTableVw.setEmptyData(msg: "No chat found.", rowCount: allMessage.count)
        return allMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = allMessage[indexPath.row]
        if message.messageType == 2 {
            let cell = chatTableVw.dequeueReusableCell(withIdentifier: "SenderTVCell", for: indexPath) as! SenderTVCell
            if allMessage.count > 0 {
                cell.setMessageData(message: message, recieverImage: receiverImg)
            }
            return cell
        } else {
            let cell = chatTableVw.dequeueReusableCell(withIdentifier: "ReceiverTVCell", for: indexPath) as! ReceiverTVCell
            if allMessage.count > 0 {
                cell.setMessageData(message: message)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: -> Get messages

extension ChatVC {
    
    private func activateListeners(){
        
        //MARK: - Chat Messages Listener
        
        SocketIOManager.sharedInstance.get_All_Chat_Listner { [weak self] messages in
            self?.allMessage = messages
            self?.chatTableVw.reloadData()
            self?.chatTableVw.scrollToBottom(animated: true)
            self?.view.layoutIfNeeded()
        }
        
        //MARK: - Send Message Listener
        
        SocketIOManager.sharedInstance.send_Message_Listnener { [weak self] messageInfo in
            self?.allMessage.append(messageInfo)
            self?.txtView.resignFirstResponder()
            self?.chatTableVw.scrollToBottom(animated: true)
            self?.txtView.text = ""
            self?.chatTableVw.reloadData()
        }
        
        //MARK: - Recieve Message Listener
        
        SocketIOManager.sharedInstance.recieveMessage { [weak self] messageInfo in
            self?.allMessage.append(messageInfo)
            self?.txtView.resignFirstResponder()
            self?.chatTableVw.scrollToBottom(animated: true)
            self?.txtView.text = ""
            self?.chatTableVw.reloadData()
        }
        
        //MARK: - Clear User Chat Listener
        
        SocketIOManager.sharedInstance.delete_Chat_listener { [weak self] in
            self?.fetchMessages()
        }
        
        //MARK: - Block User Listener
        
        SocketIOManager.sharedInstance.blockUserListner { [weak self] (message) in
            self?.dismiss(animated: false)
            CommonUtilities.shared.showSwiftAlert(message: message, isSuccess: .success)
        }
        
        //MARK: - Report User Listener
        
        SocketIOManager.sharedInstance.reportUserListner{ [weak self] message in
            CommonUtilities.shared.showSwiftAlert(message: message, isSuccess: .success)
            self?.dismiss(animated: false)
        }
        
        SocketIOManager.sharedInstance.blockUserListner2 { [weak self] (message ,status)  in
            if status == 1 {
                self?.blockerView.isHidden = false
                self?.blockLabel.text = message
            } else {
                self?.blockerView.isHidden = true
                self?.blockLabel.text = message
            }
        }
        
        SocketIOManager.sharedInstance.blockUserListner3 { [weak self] (message ,status)  in
            if status == 1 {
                self?.blockerView.isHidden = false
                self?.blockLabel.text = message
            } else {
                self?.blockerView.isHidden = true
                self?.blockLabel.text = message
            }
        }
        
        
    }
    
    //MARK: - Block User Emitter
    
    private func blockUser(onSuccess: @escaping(()->())){
        SocketIOManager.sharedInstance.blockUserEmitter(receiverId: receiverId)
    }
    
    
    //MARK: - Report User Emitter

    private func reportUser(str:String){
        SocketIOManager.sharedInstance.reportUserEmitter(receiverId: receiverId, comment: str)
    }
    
    //MARK: - Fetch Message Emitter
    
    private func fetchMessages(){
        SocketIOManager.sharedInstance.myChatListing(receiverId: receiverId)
    }
    
    //MARK: - Send Message Emitter
    
    private func sendMessage(type:String, msg: [String:Any]){
        SocketIOManager.sharedInstance.sendMessageEmitter(receiverId: receiverId, message: msg)
    }
    
    //MARK: - Clear Chat Emitter
    
    private func clearChat(){
        SocketIOManager.sharedInstance.clearChat(receiverId: receiverId)
    }
}
