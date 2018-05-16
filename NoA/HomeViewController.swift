//
//  HomeViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/04/26.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let ref = Database.database().reference()
    
    var contentArray: [DataSnapshot] = [] //Fetchしたデータを入れておく配列、この配列をTableViewで表示
    
    var snap: DataSnapshot! //FetchしたSnapshotsを格納する変数
    var kosu: Int = 0
    var dainyu: Int = 0
    var namae: String = ""
    var adana: String = ""
    var syoukai: String = ""
    var QRImage: UIImage!
    
    @IBOutlet var namaeLabel: UILabel!
    @IBOutlet var adanaLabel: UILabel!
    @IBOutlet var syoukaiTextView: UITextView!
    @IBOutlet var QRImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.read()
        dainyu = kosu - 1
        print(dainyu)
        print("QRイメージおくれてますか")
        print(QRImage)
        
       namaeLabel.text = String(namae)
       adanaLabel.text = String(adana)
       syoukaiTextView.text = String(syoukai)
       QRImageView.image = QRImage!
       //QRImageView.image = QRImage!
       
      
        // Do any additional setup after loading the view.
 
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func composeBottunTapped() {
        self.performSegue(withIdentifier: "Compose", sender: self)
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
