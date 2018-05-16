//
//  TourokuViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/04/26.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class TourokuViewController: UIViewController,UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let ref = Database.database().reference() //FirebaseDatabaseのルートを指定
    
    @IBOutlet var namaeTextField : UITextField!
    @IBOutlet var adanaTextField : UITextField!
    @IBOutlet var syumiTextField : UITextField!
    @IBOutlet var syussinTextfield : UITextField!
    @IBOutlet var snsTextField : UITextField!
    @IBOutlet var syoukaiTextField : UITextField!
    @IBOutlet var kaoImageView : UIImageView!
    @IBOutlet var kaoImageButton : UIButton!
    
    var okuruImage: UIImage!
    
    func presentPickerController(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(picker,animated: true,completion: nil)
        }
        
    }
    
/*    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        kaoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
    }
 */
    
    // 写真を選んだ後に呼ばれる処理
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 選択した写真を取得する
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        // ビューに表示する
        self.kaoImageView.image = image
        // 写真を選ぶビューを引っ込める
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        namaeTextField.delegate = self
        adanaTextField.delegate = self
        syumiTextField.delegate = self
        syussinTextfield.delegate = self
        snsTextField.delegate = self
        syoukaiTextField.delegate = self
        
        
        
    /*    let QRData = String(stringInterpolation: namaeTextField.text!, adanaTextField.text!, syumiTextField.text!, snsTextField.text!, syoukaiTextField.text!)
        
        print(QRData)
        
    */

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func touroku(sender: UIButton) {
        //投稿のためのメソッド
        create()
/*        print("(＾ω＾)")
        print(okuruImage)
        
        func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            var secondViewController:HomeViewController = segue.destination as! HomeViewController
            secondViewController.namae = namaeTextField.text!
            secondViewController.adana = adanaTextField.text!
            secondViewController.syoukai = syoukaiTextField.text!
            secondViewController.QRImage = okuruImage
            print("これが送るイメージ")
            print(okuruImage)
        }
        
*/
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
        
        let QRData = String(stringInterpolation: namaeTextField.text!,"|", adanaTextField.text!,"|", syumiTextField.text!,"|", snsTextField.text!,"|", syoukaiTextField.text!)
        
        print("これがQRデータ")
        print(QRData)
        
        let data = QRData.data(using: String.Encoding.utf8)!
        
        let qr = CIFilter(name: "CIQRCodeGenerator", withInputParameters: ["inputMessage": data, "inputCorrectionLevel": "M"])!
        let sizeTransform = CGAffineTransform(scaleX: 10, y: 10)
        let qrImage = qr.outputImage!.transformed(by: sizeTransform)
        //画像のリサイズ
        let context = CIContext()
        let cgImage = context.createCGImage(qrImage, from: qrImage.extent)
        let createOkuruImage = UIImage(cgImage: cgImage!)
        okuruImage = createOkuruImage
        print(createOkuruImage)
    
        
        let sendData:[String:Any] = [
            "user": (Auth.auth().currentUser?.uid)!,
            "namaecontent": namaetext,
            "adanacontent": adanatext,
            "syumicontent": syumitext,
            "syussincontent": syussintext,
            "snscontent": snstext,
            "syoukaicontent": syoukaitext,
            "date": ServerValue.timestamp()
        ]
        
        let message = ref.child((Auth.auth().currentUser?.uid)!).childByAutoId()
        
         message.setValue(sendData)

        //ロートからログインしているユーザーのIDをchildにしてデータを作成
        //childByAutoId()でユーザーIDの下に、IDを自動生成してその中にデータを入れる
        //setValueでデータを送信する。第一引数に送信したいデータを辞書型で入れる
        //今回は記入内容と一緒にユーザーIDと時間を入れる
        //FIRServerValue.timestamp()で現在時間を取る
        /*self.ref.child((Auth.auth().currentUser?.uid)!).childByAutoId().setValue["user",: (Auth.auth()?.currentUser?.uid)!,"namaecontent": namaetext,"adanacontent": adanatext,"syumicontent": syumitext,"syussincontent": syussintext,"snscontent": snstext,"syoukaicontent": syoukaitext, "date": ServerValue.timestamp()]
 */
        
        
    }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        create()
        print("送るイメージの確認")
        print(okuruImage)
        
        var secondViewController:HomeViewController = segue.destination as! HomeViewController
        secondViewController.namae = namaeTextField.text!
        secondViewController.adana = adanaTextField.text!
        secondViewController.syoukai = syoukaiTextField.text!
        secondViewController.QRImage = okuruImage
        print("これが送るイメージ")
        print(okuruImage)
    }

    
    @IBAction func tap() {
        let actionAlert = UIAlertController(title: "アイコンを追加", message: "写真を撮影または洗濯してください", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        //UIAlertControllerにカビゴンのアクションを追加する
        let kabigonAction = UIAlertAction(title: "カメラロール", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("カメラロールが選択されました。")
            self.presentPickerController(sourceType: .photoLibrary)
            
            
        })
        actionAlert.addAction(kabigonAction)
        
        //UIAlertControllerにピカチュウのアクションを追加する
        let pikachuAction = UIAlertAction(title: "カメラ", style: UIAlertActionStyle.default, handler: {
            (action: UIAlertAction!) in
            print("カメラが選択されました。")
            self.presentPickerController(sourceType: .camera)
        })
        actionAlert.addAction(pikachuAction)
        
        //UIAlertControllerにキャンセルのアクションを追加する
        let cancelAction = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: {
            (action: UIAlertAction!) in
            print("キャンセルのシートが押されました。")
            
        })
        actionAlert.addAction(cancelAction)
        
        //アクションを表示する
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
