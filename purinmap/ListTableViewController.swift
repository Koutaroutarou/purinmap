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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return 30
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        as! ListTableViewCell
        
        let getStar = pudding.reviewStarRealm
        let getName = pudding.shopName
        
        cell.star.text = getStar
        cell.name.text = getName
        
        return cell
    }

    

}
