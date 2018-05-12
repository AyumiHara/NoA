//
//  SignUpViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/05/07.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet var emailTextField: UITextField! // Emailを打つためのTextField
    
    @IBOutlet var passwordTextField: UITextField! //Passwordを打つためのTextField


    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self //デリゲートをセット
        passwordTextField.delegate = self //デリゲートをセット
        passwordTextField.isSecureTextEntry = true // 文字を非表示に
        
        if self.checkUserVerify() {
            self.transitionToView()
        }
        
       // self.layoutFacebookButton()
        
        
        
    
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func willSignup() {
        //サインアップのための関数
        signup()
    }
    //ログイン画面への遷移ボタン
    @IBAction func willTransitionToLogin() {
        transitionToLogin()
    }
    
/*    @IBAction func willLoginWithFacebook() {
        self.loginWithFacebook()
    }
 */
    
    func transitionToLogin() {
        self.performSegue(withIdentifier: "toLogin", sender: self)
    }
    //ListViewControllerへの遷移
    func transitionToView() {
        self.performSegue(withIdentifier: "toView", sender: self)
    }
    //Returnキーを押すと、キーボードを隠す
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func checkUserVerify()  -> Bool {
        guard let user = FIRAuth.auth()?.currentUser else { return false }
        return user.isEmailVerified
    }
    
    func signup() {
        //emailTextFieldとpasswordTextFieldに文字がなければ、その後の処理をしない
        guard let email = emailTextField.text else  { return }
        guard let password = passwordTextField.text else { return }
        //FIRAuth.auth()?.createUserWithEmailでサインアップ
        //第一引数にEmail、第二引数にパスワード
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
            //エラーがないことを確認
            if error == nil{
                // メールのバリデーションを行う
                user?.sendEmailVerification(completion: { (error) in
                    if error == nil {
                        // エラーがない場合にはそのままログイン画面に飛び、ログインしてもらう
                        self.transitionToLogin()
                        print("大丈夫なメール")
                    }else {
                        self.presentValidateAlert()
                        print("\(error?.localizedDescription)")
                        print("大丈夫じゃないメール")
                    }
                })
            }else {
                self.presentValidateAlert()
                print("\(error?.localizedDescription)")
                print("これも大丈夫じゃないメール")
            }
        })
    }
    
    
    
    func checkUserValidate(user: FIRUser)  -> Bool {
        return user.isEmailVerified
    }
    // メールのバリデーションが完了していない場合のアラートを表示
    func presentValidateAlert() {
        let alert = UIAlertController(title: "メール認証", message: "メール認証を行ってください", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        print("アラート表示")
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
