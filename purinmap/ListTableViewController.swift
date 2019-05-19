//
//  ListTableViewController.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/05/13.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit
import RealmSwift

class ListTableViewController: UITableViewController {
    
    let realm = try!Realm()
    var pudding = PuddingList()
    var puddingArray: Results<PuddingList>!
    
    @IBAction func returnView() {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        puddingArray = realm.objects(PuddingList.self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return puddingArray.count
    }
    
    //セルに表示する
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! ListTableViewCell
        
        let getStar = puddingArray[indexPath.row].reviewStarRealm
        let getName = puddingArray[indexPath.row].shopName
        
        
        cell.star.text = getStar
        cell.name.text = getName
        
        return cell
    }
    
    //セルの編集を許可
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    
    }
    
    //スワイプでセルの情報を削除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if  editingStyle == UITableViewCell.EditingStyle.delete {
            
            
            try! realm.write {
                realm.delete(self.puddingArray![indexPath.row])
            }
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    

    

}
