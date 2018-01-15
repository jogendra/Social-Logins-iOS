//
//  ViewController.swift
//  Social Logins iOS
//
//  Created by JOGENDRA on 16/01/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController {

    let fbLoginButton = FBSDKLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(fbLoginButton)
        fbLoginButton.center = view.center
        fbLoginButton.delegate = self
    }

}

extension ViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
}

