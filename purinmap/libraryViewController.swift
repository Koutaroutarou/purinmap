//
//  libraryViewController.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/04/24.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit
import RealmSwift

class libraryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate {
    
    //前のビューから受け取る箱を用意
    var receiveLatitude: Double!
    var receiveLongitude: Double!
    var receiveShopName: String!
    var receiveComment: String!
    var receiveReview: String!
    var receiveReviewStar: String!
    
    
    
    @IBOutlet var storeName: UITextField!
    
    //Realm保存機能
    let realm = try! Realm()
    var pudding = PuddingList()
    
    @IBAction func register(_ sender: Any) {
        
        pudding.shopName = storeName.text!
        pudding.commnet = inputText.text!
        pudding.reviewStarRealm = reviewStar.text!
        pudding.review = reviewLabel.text!
        pudding.shopLatitude = receiveLatitude!
        pudding.shopLongitude = receiveLongitude!
        
        
//  写真の保存      pudding.imageData =
        
        try!realm.write{
            realm.add(pudding)
            }
        storeName.text = ""
        inputText.text = ""
        
        print("保存されました")
        print("\(pudding.shopLatitude),\(pudding.shopLongitude)")
    }
    
    
    
    //追加したところ
    var testText: String = "default"
    var reviewArray: [Dictionary<String, String>] = []
    let userDefaults = UserDefaults.standard
    //ここまで↑
    
    var tap: Int = 0
    
    @IBAction func star5() {
            reviewLabel.text = "5.0"
            reviewStar.text = "★ ★ ★ ★ ★"
            tap = 1
        
    }
    @IBAction func star4() {
            reviewLabel.text = "4.0"
            reviewStar.text = "★ ★ ★ ★ ☆"
    }
    @IBAction func star3() {
            reviewLabel.text = "3.0"
            reviewStar.text = "★ ★ ★ ☆ ☆"
    }
    @IBAction func star2() {
            reviewLabel.text = "2.0"
            reviewStar.text = "★ ★ ☆ ☆ ☆"
    }
    @IBAction func star1() {
        if tap == 1 {
            reviewLabel.text = "0.0"
            reviewStar.text = "☆ ☆ ☆ ☆ ☆"
            tap = 0
        }  else {
            reviewLabel.text = "1.0"
            reviewStar.text = "★ ☆ ☆ ☆ ☆"
        }
    }
    
    
    
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var reviewStar: UILabel!

    @IBOutlet var inputText: UITextView!
    
    //写真表示ようImageView
    @IBOutlet var imageView: UIImageView!
    
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storeName.text = receiveShopName
        inputText.text = receiveComment
        reviewStar.text = receiveReviewStar
        reviewLabel.text = receiveReview
        
        
    }
        
//追加した部分↓
        //教科書追加↓
//
//        if userDefaults.array(forKey: "REVIEW") != nil {
//
//            reviewArray = userDefaults.array(forKey: "REVIEW") as! [Dictionary<String, String>]
//        }
//
//
//
//        storeName.delegate = self
//
//        userDefaults.register(defaults: ["DataStore": "default"])
//
//        storeName.text = readData()
//
//
//
//
//
//    }
//
//    func readData() -> String {
//
//        let str: String = userDefaults.object(forKey: "DataStore") as! String
//
//        return str
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        testText = storeName.text!
//        storeName.text = testText
//
//        storeName.resignFirstResponder()
//
//        saveData(str: testText)
//
//        return true
//
//    }
//
//    func saveData(str: String) {
//
//
//        userDefaults.set(str, forKey: "DataStore")
//    }
//
    //↑ここまで追加
    
    
    
    
    
    override func didReceiveMemoryWarning() {
       super.didReceiveMemoryWarning()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //プラスボタンを押したときに呼ばれるメソッド
    @IBAction func onTappedPlusImage() {
        presentPickerController(sourceType: .photoLibrary)
    }
    
    //カメラ、アルバムの呼び出しメソッド
    func presentPickerController(sourceType: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(sourceType) {
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    
    //写真が選択されたときに呼ばれるメソッド
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        self.dismiss(animated: true, completion: nil)
        
        //画像を出力
        imageView.image = info[.originalImage]as? UIImage
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

   

}
