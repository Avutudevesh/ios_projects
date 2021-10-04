//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var chatTableView: UITableView!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="⚡️FlashChat"
        navigationItem.hidesBackButton = true
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        db.collection("messages")
            .order(by: "timeStamp")
            .addSnapshotListener() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    self.messages = []
                    for document in querySnapshot!.documents {
                        if let text = document.data()["text"] as? String, let sender = document.data()["sender"] as? String {
                            self.messages.append(Message(body: text, sender: sender))
                        }
                    }
                }
                print(self.messages)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let message = messageTextfield.text, let sender = Auth.auth().currentUser?.email{
            db.collection("messages").addDocument(data: [
                "sender": sender,
                "text": message,
                "timeStamp": Date().timeIntervalSince1970
            ]){ err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added")
                }
            }
        }
        messageTextfield.text = ""
        
    }
    
    @IBAction func onLogoutPressed(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print(error)
        }
    }
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! MessageCell
        cell.messageLabel.text = messages[indexPath.row].body
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
        } else {
            cell.rightImageView.isHidden = true
            cell.leftImageView.isHidden = false
        }
        return cell
    }
    
    
}
