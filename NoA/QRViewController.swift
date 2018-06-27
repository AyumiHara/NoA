//
//  QRViewController.swift
//  NoA
//
//  Created by 原 あゆみ on 2018/04/26.
//  Copyright © 2018年 原あゆみ. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class QRViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    // カメラやマイクの入出力を管理するオブジェクトを生成
    private let session = AVCaptureSession()
    
    @IBOutlet var tourokuButton: UIButton!
    @IBOutlet var cameraView : UIView!
    var videoLayer: AVCaptureVideoPreviewLayer?
    var jouhouArry : [String] = []
    var namae : String!
    var adana : String!
    var syumi : String!
    var syussin : String!
    var SNS : String!
    var syoukai : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // カメラやマイクのデバイスそのものを管理するオブジェクトを生成（ここではワイドアングルカメラ・ビデオ・背面カメラを指定）
        
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera],
                                                                mediaType: .video,
                                                                position: .back)
        
        // ワイドアングルカメラ・ビデオ・背面カメラに該当するデバイスを取得
        let devices = discoverySession.devices
        
        //　該当するデバイスのうち最初に取得したものを利用する
        if let backCamera = devices.first {
            do {
                // QRコードの読み取りに背面カメラの映像を利用するための設定
                let deviceInput = try AVCaptureDeviceInput(device: backCamera)
                
                if self.session.canAddInput(deviceInput) {
                    self.session.addInput(deviceInput)
                    
                    // 背面カメラの映像からQRコードを検出するための設定
                    let metadataOutput = AVCaptureMetadataOutput()
                    
                    if self.session.canAddOutput(metadataOutput) {
                        self.session.addOutput(metadataOutput)
                        
                        metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
                        metadataOutput.metadataObjectTypes = [.qr]
                        
                        // 背面カメラの映像を画面に表示するためのレイヤーを生成
                        let cameraView = AVCaptureVideoPreviewLayer(session: self.session)
                        cameraView.frame = CGRect(x:0,y:0,width:self.view.bounds.width,height:580)
                        cameraView.videoGravity = .resizeAspectFill
                        self.view.layer.addSublayer(cameraView)
                        
                        // 読み取り開始
                        self.session.startRunning()
                    }
                }
            } catch {
                print("Error occured while creating video device input: \(error)")
            }
        }
        
        //tourokuButton.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        for metadata in metadataObjects as! [AVMetadataMachineReadableCodeObject] {
            // QRコードのデータかどうかの確認
            if metadata.type != .qr { continue }
            
            // QRコードの内容が空かどうかの確認
            if metadata.stringValue == nil { continue } 
            
            /*
             このあたりで取得したQRコードを使ってゴニョゴニョする
             読み取りの終了・再開のタイミングは用途によって制御が異なるので注意
             以下はQRコードに紐づくWebサイトをSafariで開く例
             */
            
            self.session.stopRunning()
            let str = String(metadata.stringValue!)
            print(str)
            jouhouArry = str.components(separatedBy: "|")
            print(jouhouArry)
            print(jouhouArry[0])
            print(jouhouArry[1])
            print(jouhouArry[2])
            print(jouhouArry[3])
            print(jouhouArry[4])
            print(jouhouArry[5])
            
            namae = jouhouArry[0]
            adana = jouhouArry[1]
            syumi = jouhouArry[2]
            syussin = jouhouArry[3]
            SNS = jouhouArry[4]
            syoukai = jouhouArry[5]
            
            /* let storyboard: UIStoryboard = self.storyboard!
             let nextView = storyboard.instantiateViewController(withIdentifier: "Tuika") as! TomodatiViewController
             self.present(nextView, animated: true, completion: nil)
             */
            break
            
            
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print(jouhouArry)
        
        if jouhouArry.isEmpty {
            print("配列がからです")
            let alert: UIAlertController = UIAlertController(title: "アラート表示", message: "QRコードが見つかっていません", preferredStyle:  UIAlertControllerStyle.alert)
            
            // ② Actionの設定
            // Action初期化時にタイトル, スタイル, 押された時に実行されるハンドラを指定する
            // 第3引数のUIAlertActionStyleでボタンのスタイルを指定する
            // OKボタン
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler:{
                // ボタンが押された時の処理を書く（クロージャ実装）
                (action: UIAlertAction!) -> Void in
                print("OK")
            })
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        } else {
      
        var secondViewController:TomodatiViewController = segue.destination as! TomodatiViewController
        TomodatiViewController.namae = namae
        TomodatiViewController.adana = adana
        TomodatiViewController.syumi = syumi
        TomodatiViewController.syussin = syussin
        TomodatiViewController.SNS = SNS
        TomodatiViewController.syoukai = syoukai
        secondViewController.torimaArry = jouhouArry

        
        
        print("このデータを送る")
        print(TomodatiViewController.namae)
        print(TomodatiViewController.adana)
        print(TomodatiViewController.syumi)
        print(TomodatiViewController.syussin)
        print(TomodatiViewController.SNS)
        print(TomodatiViewController.syoukai)
        print("このデータを送った")
 
        }
        
        
    }
    
    
    
    @IBAction func touroku() {
        self.performSegue(withIdentifier: "toTuika", sender: self)
    }
    
}

