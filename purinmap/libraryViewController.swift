//
//  libraryViewController.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/04/24.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit

class libraryViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var storeName: UITextField!
    
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

        // Do any additional setup after loading the view.
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
        self.dismiss(animated: true, completion: nil)
        
        //画像を出力
        imageView.image = info[.originalImage]as? UIImage
    }
    
    @IBAction func back() {
        self.dismiss(animated: true, completion: nil)
    }

   

}
