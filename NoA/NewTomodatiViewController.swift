//
//  NewTomodatiViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/06/08.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit

class NewTomodatiViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var purohuArray : [Dictionary<String, String>] = []
    let saveData = UserDefaults.standard
    @IBOutlet var namaeLabel : UILabel!
    @IBOutlet var adanalabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ニュー友達")
        tableView.register(UINib(nibName: "TomodatiTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if saveData.array(forKey: "WORD") != nil{
            purohuArray = saveData.array(forKey: "WORD") as! [Dictionary<String, String>]
        }
        tableView.reloadData()
        print("リロード中")
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
       return 1
    }
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return purohuArray.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tomodatiCell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nowIndexPathDictionary = purohuArray[indexPath.row]
        
        
        print("セルの中に入るやつ")
        print(nowIndexPathDictionary["namae"] as Any)
        print(nowIndexPathDictionary["namae"] as Any)
        
        tomodatiCell.textLabel?.text = nowIndexPathDictionary["namae"]
        //adanalabel.text = nowIndexPathDictionary["adana"]
        
        return tomodatiCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
