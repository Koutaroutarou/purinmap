//
//  ViewController.swift
//  purinmap
//
//  Created by 渡辺航太郎 on 2019/04/19.
//  Copyright © 2019 litech. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet var textField: UITextField!
    
    var pickerView: UIPickerView = UIPickerView()
    let list = ["現在地", "渋谷", "横浜", "原宿"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.showsSelectionIndicator = true


        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done , target: self, action: #selector(pickerSlected))

        toolbar.setItems([doneItem], animated: true)

        self.textField.inputView = pickerView
        self.textField.inputAccessoryView = toolbar

    }
    
    @objc func pickerSlected() {
        print( pickerView.selectedRow(inComponent: 0) )
        print("selected something")
        textField.resignFirstResponder()
        
    }
        
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            
            return 1
        }
    
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            
            return list.count
        }
    
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            
            return list[row]
        }
    
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.textField.text = list[row]
    }
    
        
        func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
            
            return CGRect(x: x, y: y, width: width, height: height)
        }
    
    var regionNumber: Int = 0
    
    @IBAction func toTappedPdding() {
        if textField.text == list[0] {
            //list[0]の地域だけの地図を表示
            regionNumber = 0
            
            self.performSegue(withIdentifier: "toMap", sender: textField.text)
            
        } else if textField.text == list[1] {
            //指定した地域だけの地図を表示
            regionNumber = 1
            
            self.performSegue(withIdentifier: "toMap", sender: textField.text)
          
            
        } else if textField.text == list[2] {
            //指定した地域だけの地図を表示
            regionNumber = 2
            
            self.performSegue(withIdentifier: "toMap", sender: textField.text)
           
            
        } else if textField.text == list[3] {
            //指定した地域だけの地図を表示
            regionNumber = 3
            
            self.performSegue(withIdentifier: "toMap", sender: textField.text)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMap" {
            let navigation = segue.destination as! UINavigationController
            let viewController = navigation.topViewController as! mapViewController
            viewController.regionNumber2 = (sender as! String)
        }
    }
        
    

}

