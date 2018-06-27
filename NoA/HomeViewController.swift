//
//  HomeViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/04/26.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class HomeViewController: UIViewController {
    
    let ref = Database.database().reference()
    
    var contentArray: [DataSnapshot] = [] //Fetchしたデータを入れておく配列、この配列をTableViewで表示
    
    var snap: DataSnapshot! //FetchしたSnapshotsを格納する変数
    var kosu: Int = 0
    var dainyu: Int = 0
    static var namae: String = ""
    static var adana: String = ""
    static var syoukai: String = ""
    static var QRImage: UIImage = UIImage()
    
    @IBOutlet var namaeLabel: UILabel!
    @IBOutlet var adanaLabel: UILabel!
    @IBOutlet var syoukaiTextView: UITextView!
    @IBOutlet  var QRImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.read()
        dainyu = kosu - 1
        print(dainyu)
        print("QRイメージおくれてますか")
        print(HomeViewController.QRImage)
        
        namaeLabel.text = String(HomeViewController.namae)
        adanaLabel.text = String(HomeViewController.adana)
        syoukaiTextView.text = String(HomeViewController.syoukai)
        QRImageView.image = HomeViewController.QRImage
       
        
        
        if self.checkUserVerify() {
           dispAlert()
        }
       
      
        // Do any additional setup after loading the view.
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func checkUserVerify()  -> Bool {
        guard let user = Auth.auth().currentUser else { return false }
        return user.isEmailVerified
    }

    
    func dispAlert() {
        
        // ① UIAlertControllerクラスのインスタンスを生成
        // タイトル, メッセージ, Alertのスタイルを指定する
        // 第3引数のpreferredStyleでアラートの表示スタイルを指定する
        let alert: UIAlertController = UIAlertController(title: "ログイン・サインアップ確認", message: "ログイン・サインアップ画面に移ります", preferredStyle:  UIAlertControllerStyle.alert)
        
        // ② Actionの設定
        // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
        // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
        // OKボタン
        let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
            // ボタンが押された時の処理を書く（クロージャ実装）
            (action: UIAlertAction!) -> Void in
            print("OK")
        })
        // キャンセルボタン
    
        alert.addAction(defaultAction)
        
        // ④ Alertを表示
        present(alert, animated: true, completion: nil)
    }
    
    
/*    func read()  {
        //FIRDataEventTypeを.Valueにすることにより、なにかしらの変化があった時に、実行
        //今回は、childでユーザーIDを指定することで、ユーザーが投稿したデータの一つ上のchildまで指定することになる
        ref.child((Auth.auth().currentUser?.uid)!).observe(.value, with: {(snapShots) in
            if snapShots.children.allObjects is [DataSnapshot] {
                print("snapShots.children...\(snapShots.childrenCount)") //いくつのデータがあるかプリント
                self.kosu = Int(snapShots.childrenCount)
                print("個数\(self.kosu)")
                
                print("snapShot...\(snapShots)") //読み込んだデータをプリント
                
                self.snap = snapShots
                
                let item = self.contentArray[Int(self.dainyu)]
                print("ここを見て")
                print(self.contentArray[self.kosu])
                let content = item.value as! Dictionary<String, AnyObject>
                //contentという添字で保存していた投稿内容を表示
                self.namaeLabel.text = String(describing: content["namaecontent"]!)
                self.adanaLabel.text = String(describing: content["adanacontent"]!)
                self.syoukaiTestField.text = String(describing: content["syoukaicontent"])
                
                
            }
            self.reload(snap: self.snap)
        })
    }
*/
    func reload(snap: DataSnapshot) {
        if snap.exists() {
            print(snap)
            //FIRDataSnapshotが存在するか確認
            contentArray.removeAll()
            //1つになっているFIRDataSnapshotを分割し、配列に入れる
            for item in snap.children {
                contentArray.append(item as! DataSnapshot)
                print(contentArray)
            }
            // ローカルのデータベースを更新
            ref.child((Auth.auth().currentUser?.uid)!).keepSynced(true)
        }
    }
    
    @IBAction func ichiraneBottunTapped() {
        if (TomodatiViewController.purohuArry != nil){
        self.performSegue(withIdentifier: "toIchiran", sender: self)
        } else{
            let alert = UIAlertController(title: "友達がいません", message: "＋ボタンから友達のQRを読み取ってください", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            print("アラート表示")

        }
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
