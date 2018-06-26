//
//  TomodatiViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/05/17.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit

class TomodatiViewController: UIViewController {
    
    let saveData = UserDefaults.standard
    
    @IBOutlet var namaeLabel: UILabel!
    @IBOutlet var adanaLabel: UILabel!
    @IBOutlet var syumiLabel: UILabel!
    @IBOutlet var syussinLabel: UILabel!
    @IBOutlet var SNSLabel: UILabel!
    @IBOutlet var syoukaiTextView: UITextView!
   
    
    var namae : String = ""
    var adana : String = ""
    var syumi : String = ""
    var syussin : String = ""
    var SNS : String = ""
    var syoukai : String = ""
    var torimaArry : [String] = []
    var purohuArry : [Dictionary<String, String>] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        namaeLabel.text = namae
        adanaLabel.text = adana
        syumiLabel.text = syumi
        syussinLabel.text = syussin
        SNSLabel.text = SNS
        syoukaiTextView.text = syoukai
        
        
        
        
        if saveData.array(forKey: "WORD") != nil {
            purohuArry = saveData.array(forKey: "WORD") as! [Dictionary<String, String>]
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func save() {
        
        let purohuDictionary = ["namae":namae, "adana":adana, "syumi":syumi, "syussin":syussin, "sns":SNS, "syoukai":syoukai] as [String : Any]
        
        
        
        print("これが辞書")
        print(purohuDictionary)
        
        purohuArry.append(purohuDictionary as! [String : String])
        saveData.set(purohuDictionary, forKey: "WORD")
        let actionAlert = UIAlertController(title: "プロフを保存",
                                            message: "プロフを保存しますか？",
                                            preferredStyle: UIAlertControllerStyle.actionSheet)
        
        actionAlert.addAction(UIAlertAction(
            title: "保存する！",
            style: .default,
            handler: {
                (action: UIAlertAction!) in
                print("保存が選択された")
                print( self.saveData.set(purohuDictionary, forKey: "WORD"))
                //self.performSegue(withIdentifier: "toTable", sender: self)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        }
        ))
        
        actionAlert.addAction(UIAlertAction(
            title: "キャンセル",
            style: UIAlertActionStyle.cancel,
            handler: {
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("Cancel")
        }
     ))
        self.present(actionAlert, animated: true, completion: nil)
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
