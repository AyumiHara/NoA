//
//  TourokuViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/04/26.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Firebase

class TourokuViewController: UIViewController,UITextFieldDelegate {
    
    let ref = FIRDatabase.database().reference() //FirebaseDatabaseのルートを指定
    
    @IBOutlet var namaeTextField : UITextField!
    @IBOutlet var adanaTextField : UITextField!
    @IBOutlet var syumiTextField : UITextField!
    @IBOutlet var syussinTextfield : UITextField!
    @IBOutlet var snsTextField : UITextField!
    @IBOutlet var syoukaiTextField : UITextField!
    @IBOutlet var kaoImageView : UIImageView!
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        namaeTextField.delegate = self
        adanaTextField.delegate = self
        syumiTextField.delegate = self
        syussinTextfield.delegate = self
        snsTextField.delegate = self
        syoukaiTextField.delegate = self
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touroku(sender: UIButton) {
        //投稿のためのメソッド
        create()
        
    }
    
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func create() {
        //textFieldになにも書かれてない場合は、その後の処理をしない
        guard let namaetext = namaeTextField.text else { return }
        guard let adanatext = adanaTextField.text else { return }
        guard let syumitext = syumiTextField.text else { return }
        guard let syussintext = syussinTextfield.text else { return }
        guard let snstext = snsTextField.text else { return }
        guard let syoukaitext = syoukaiTextField.text else { return }
        
        
        
        
        //ロートからログインしているユーザーのIDをchildにしてデータを作成
        //childByAutoId()でユーザーIDの下に、IDを自動生成してその中にデータを入れる
        //setValueでデータを送信する。第一引数に送信したいデータを辞書型で入れる
        //今回は記入内容と一緒にユーザーIDと時間を入れる
        //FIRServerValue.timestamp()で現在時間を取る
        self.ref.child((FIRAuth.auth()?.currentUser?.uid)!).childByAutoId().setValue(["user": (FIRAuth.auth()?.currentUser?.uid)!,"namaecontent": namaetext,"adanacontent": adanatext,"syumicontent": syumitext,"syussincontent": syussintext,"snscontent": snstext,"syoukaicontent": syoukaitext, "date": FIRServerValue.timestamp()])
        
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
