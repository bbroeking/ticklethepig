//
//  LeaderboardViewController.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 10/7/19.
//  Copyright © 2019 Brian Broeking. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

struct cellData {
    var uid: String
    var count: Int
}
class TableViewController: UITableViewController {

    var db = Firestore.firestore()
    var currentUser = Auth.auth().currentUser
    var tableViewData = [cellData]()
        
    @IBOutlet weak var gifView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getLeaders()
        gifView.loadGif(name: "SupportFiles/pig")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func getLeaders() {
        let query: Query = self.db.collection("tickles").order(by: "numTickles", descending: true).limit(to: 100)
        query.addSnapshotListener { (snapshot, err) in
            guard let snapshot = snapshot else {
              return
            }
            self.tableViewData = []
            for document in snapshot.documents {
                let item: cellData = cellData(uid: document.data()["username"] as! String, count: document.data()["numTickles"] as! Int)
                self.tableViewData.append(item)
            }
            self.tableView.reloadData()
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaderboardCell
        cell.setCell(cell: self.tableViewData[indexPath.row])
        return cell
    }
    
}
