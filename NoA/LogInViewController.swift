//
//  LogInViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/05/07.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage

class LogInViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField! // Emailを打つためのTextField
    
    @IBOutlet var passwordTextField: UITextField! //Passwordを打つためのTextField
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self //デリゲートをセット
        passwordTextField.delegate = self //デリゲートをセット
        passwordTextField.isSecureTextEntry  = true // 文字を非表示に
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //ログインしていれば、遷移
        //FIRAuthがユーザー認証のためのフレーム
        //checkUserVerifyでチェックして、ログイン済みなら画面遷移
        print(self.checkUserVerify())
        if self.checkUserVerify() {
             print("toTouroku動いてます")
            self.performSegue(withIdentifier: "toTouroku", sender: nil)
           
        }
    }
    
    func checkUserVerify()  -> Bool {
        guard let user = Auth.auth().currentUser else { return false }
        return user.isEmailVerified
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //ログインボタン
    @IBAction func didRegisterUser() {
        //ログインのためのメソッド
        login()
        
    }
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //ログイン完了後に、ListViewControllerへの遷移のためのメソッド
 
    
    func login() {
        //EmailとPasswordのTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        //signInWithEmailでログイン
        //第一引数にEmail、第二引数にパスワードを取ります
        Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
            //エラーがないことを確認
            if error == nil {
                if let loginUser = user {
                    // バリデーションが完了しているか確認。完了ならそのままログイン
                    if self.checkUserValidate(user: Auth.auth().currentUser!) {
                        // 完了済みなら、ListViewControllerに遷移
                        print(Auth.auth().currentUser)
                     
                        self.performSegue(withIdentifier: "toTouroku", sender: nil)
                    }else {
                        // 完了していない場合は、アラートを表示
                        self.presentValidateAlert()
                    }
                }
            }else {
                print("error...\(error?.localizedDescription)")
                let alert = UIAlertController(title: "認証エラー", message: "アドレスまたはパスワードが間違えているか、アカウントが登録されていません。", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    
    func checkUserValidate(user: User)  -> Bool {
        return user.isEmailVerified
    }
    // メールのバリデーションが完了していない場合のアラートを表示
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func logout() {
        do {
            //do-try-catchの中で、FIRAuth.auth()?.signOut()を呼ぶだけで、ログアウトが完了
            try Auth.auth().signOut()
            
            //先頭のNavigationControllerに遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Nav")
            self.present(storyboard, animated: true, completion: nil)
        }catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
    }
    
    
}
