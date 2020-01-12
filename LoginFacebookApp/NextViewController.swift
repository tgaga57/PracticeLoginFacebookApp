//
//  NextViewController.swift
//  LoginFacebookApp
//
//  Created by 志賀大河 on 2020/01/12.
//  Copyright © 2020 Taigashiga. All rights reserved.
//

import UIKit
import SDWebImage
class NextViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    
    @IBOutlet var useNameLabel: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.object(forKey: "pictureURLString") != nil || (UserDefaults.standard.object(forKey: "displayName") != nil){
            
            let imageString = UserDefaults.standard.object(forKey: "pictureURLString") as! String
            profileImageView.sd_setImage(with: URL(string: imageString), completed: nil)
            
            profileImageView.layer.cornerRadius = 20.0
        }

    }
    

  

}
