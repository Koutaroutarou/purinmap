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
    
    
    var getStar: String!
    var getReview: String!
    var getImage: UIImage!
    var getName: String!
    var getComment: String!
    
    
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
        
         getStar = puddingArray[indexPath.row].reviewStarRealm
         getName = puddingArray[indexPath.row].shopName
         getImage = puddingArray[indexPath.row].purinImage
         
        
        
        cell.star.text = getStar
        cell.name.text = getName
        cell.picture.image = getImage
        
        
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
//    セルを選択して画面遷移
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        getStar = puddingArray[indexPath.row].reviewStarRealm
        getName = puddingArray[indexPath.row].shopName
        getImage = puddingArray[indexPath.row].purinImage
        getComment = puddingArray[indexPath.row].commnet
        getReview = puddingArray[indexPath.row].review
        
        performSegue(withIdentifier: "toResult", sender: (Any).self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toResult" {
            
            let navigation = segue.destination as! UINavigationController
            let ResultViewController: ResultViewController = navigation.topViewController as! ResultViewController
            
            ResultViewController.getComment = self.getComment
            ResultViewController.getImage = self.getImage
            ResultViewController.getName = self.getName
            ResultViewController.getStar = self.getStar
            ResultViewController.getReview = self.getReview
            
            
        }
    }
    

}
