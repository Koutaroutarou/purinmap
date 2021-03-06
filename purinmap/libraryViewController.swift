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
    //新規保存用
    var newLatitude: Double!
    var newLongitude: Double!
    //保存されているもの表示用、更新用
    var receiveShopName: String!
    var receiveComment: String!
    var receiveReview: String!
    var receiveReviewStar: String!
    var receiveLatitude: Double!
    var receiveLongitude: Double!
    var receiveVersion: Int!
    var receiveImage: UIImage!
    var receiveId: Int!
    
    
    
    
    @IBOutlet var storeName: UITextField!
    var photo: UIImage!
    
    
    //Realm保存機能
    let realm = try! Realm()
    var pudding: PuddingList?
    
    @IBAction func register(_ sender: Any) {
    //データがなければ新規保存
        
        if receiveVersion == 0 {
            
            pudding = PuddingList()
            pudding!.shopName = storeName.text!
            pudding!.commnet = inputText.text!
            pudding!.reviewStarRealm = reviewStar.text!
            pudding!.review = reviewLabel.text!
            pudding!.shopLatitude = newLatitude!
            pudding!.shopLongitude = newLongitude!
            if let primaryId = realm.objects(PuddingList.self).last {
                pudding!.id = primaryId.id + 1
            } else {
                pudding!.id = 0
            }

            
            guard let _selectedImage = selectedImage else {
                print("画像を選択してね")
                return
            }
            pudding!.purinImage = photo
            
            try! realm.write{
                realm.add(pudding!)
                }
            
            
            let alert = UIAlertController(
                title: "保存完了", message: "お店の情報が保存されました", preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil
            
            ))
            self.present(alert, animated: true, completion:  nil)
            storeName.text = ""
            inputText.text = ""
            print("保存されました")
            print("\(pudding!.shopLatitude),\(pudding!.shopLongitude)")
            
        } else  {
    //データがすでにある場合は情報の更新
            pudding = PuddingList()
            pudding!.shopName = storeName.text!
            pudding!.commnet = inputText.text!
            pudding!.reviewStarRealm = reviewStar.text!
            pudding!.review = reviewLabel.text!
            pudding!.shopLatitude = receiveLatitude!
            pudding!.shopLongitude = receiveLongitude!
            pudding!.purinImage = selectedImage!.image
            pudding!.id = receiveId!
//            if let primaryId = realm.objects(PuddingList.self).last {
//                pudding!.id = primaryId.id + 1
//            } else {
//                pudding!.id = 0
//            }

            
//            try! realm.add(pudding!, update: true)
            try! realm.write {
                realm.add(pudding!, update: true)
            }

            
            let alert = UIAlertController(
                title: "更新完了", message: "お店の情報が更新されました", preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "OK!", style: .default, handler: nil
                
            ))
            self.present(alert, animated: true, completion:  nil)
            
            print("更新完了")
        }
                
        
    }
    
    
    
    //追加したところ
    var testText: String = "default"
    var reviewArray: [Dictionary<String, String>] = []
    let userDefaults = UserDefaults.standard
    //ここまで↑
    
    var tap: Int = 0
    
    @IBAction func starPlus() {
        if tap == 0 {
            
            reviewLabel.text = "1.0"
            reviewStar.text = "★ ☆ ☆ ☆ ☆"
            tap = 1
            
        } else if tap == 1 {
            
            reviewLabel.text = "2.0"
            reviewStar.text = "★ ★ ☆ ☆ ☆"
            tap = 2
            
        } else if tap == 2 {
            
            reviewLabel.text = "3.0"
            reviewStar.text = "★ ★ ★ ☆ ☆"
            tap = 3
            
        } else if tap == 3 {
            
            reviewLabel.text = "4.0"
            reviewStar.text = "★ ★ ★ ★ ☆"
            tap = 4
            
        } else if tap == 4 {
            
            reviewLabel.text = "5.0"
            reviewStar.text = "★ ★ ★ ★ ★"
            tap = 0
            
        }
    }
  
    
    
    
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var reviewStar: UILabel!

    @IBOutlet var inputText: UITextView!
    
    //写真表示ようImageView
    @IBOutlet var selectedImage: UIImageView!
    
    
    
    
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        storeName.text = receiveShopName
        inputText.text = receiveComment
        reviewStar.text = receiveReviewStar
        reviewLabel.text = receiveReview
        selectedImage.image = receiveImage
       
    }
    
    
    
    
    
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
        photo = info[.originalImage]as? UIImage
    
        //画像を出力
        selectedImage.image = photo
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

   

}
