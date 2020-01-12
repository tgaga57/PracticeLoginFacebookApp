//
//  ViewController.swift
//  LoginFacebookApp
//
//  Created by 志賀大河 on 2020/01/11.
//  Copyright © 2020 Taigashiga. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FacebookCore
import FacebookLogin
import Firebase

class ViewController: UIViewController,LoginButtonDelegate {
    
    let fbLoginButton:FBLoginButton = FBLoginButton()
    var displayName = String()
    var pictureURL = String()
    var pictureURLString = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fbLoginButton.delegate = self
        
        // facebookボタンの作成
        fbLoginButton.frame = CGRect(x: view.frame.size.width/2 - view.frame.size.width/4, y: view.frame.size.width/4 , width: view.frame.size.width/2, height: 30)
        fbLoginButton.permissions = ["public_profile,email"]
        view.addSubview(fbLoginButton)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // ナビゲーションコントローラーのbarを隠す
        navigationController?.isNavigationBarHidden = true
    }
    
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        // ログイン機能
        if error == nil {
            // キャンセルボタンがおされたら
            if result?.isCancelled == true {
                
                return
            }
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
        
        print("login")
        
        Auth.auth().signIn(with: credential) { (result, error) in
            
            //　オプショナルバインディング
            if let error = error {
                
                return
                
            }
            // プロフィール画像と名前の取得
            self.displayName = result!.user.displayName!
            self.pictureURLString = result!.user.photoURL!.absoluteString
            //　写真をでかくする
            self.pictureURLString = self.pictureURLString + "?type=large"
            UserDefaults.standard.set(1, forKey:"loginOK")
            UserDefaults.standard.set(self.displayName, forKey: "displayName")
            UserDefaults.standard.set(self.pictureURLString, forKey: "pictureURLString")
            
            
            
            // 画面遷移
            let nextVC = self.storyboard?.instantiateViewController(identifier: "next") as! NextViewController
            self.navigationController?.pushViewController(nextVC, animated: true)
            
            
        }
        
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
        return true
        
    }
    
    // ログアウトボタンが押されたとき
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("ログアウトしました")
    }
    
    
}

