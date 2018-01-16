//
//  ViewController.swift
//  Social Logins iOS
//
//  Created by JOGENDRA on 16/01/18.
//  Copyright © 2018 Jogendra Singh. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import GoogleSignIn
import TwitterKit

fileprivate enum Defaults {
    static let buttonTopAnchor: CGFloat = 66.0
    static let buttonLeadingAnchor: CGFloat = 32.0
    static let buttonTrailingAnchor: CGFloat = 32.0
}

class ViewController: UIViewController {

    let fbLoginButton = FBSDKLoginButton()
    let googleSignInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialUISetups()
    }
    
    // MARK: - Initial UI Setups
    func initialUISetups() {
        
        
    }
    
    fileprivate func facebookButtonSetup() {
        // Facebook Login Button Setups
        view.addSubview(fbLoginButton)
        fbLoginButton.delegate = self
        fetchUserProfileData()
        if let facebookButtonHeightConstraint = fbLoginButton.constraints.first(where: { $0.firstAttribute == .height }) {
            fbLoginButton.removeConstraint(facebookButtonHeightConstraint)
        }
        // Add Constraints to fb login button
        fbLoginButton.translatesAutoresizingMaskIntoConstraints = false
        fbLoginButton.topAnchor.constraint(equalTo: view.topAnchor, constant: Defaults.buttonTopAnchor).isActive = true
        fbLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Defaults.buttonLeadingAnchor).isActive = true
        fbLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Defaults.buttonTrailingAnchor).isActive = true
        fbLoginButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
    }
    
    fileprivate func googleButtonSetup() {
        // Google Sign In Button Setups
        view.addSubview(googleSignInButton)
        googleSignInButton.style = .wide
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        // Add Constraints to Google Sign In Button
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.topAnchor.constraint(equalTo: fbLoginButton.topAnchor, constant: Defaults.buttonTopAnchor).isActive = true
        googleSignInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Defaults.buttonLeadingAnchor).isActive = true
        googleSignInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Defaults.buttonTrailingAnchor).isActive = true
    }
    
    fileprivate func twitterButtonSetup() {
        // Twitter Login Button
        let twitterLoginButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                debugPrint("signed in as \(session?.userName)")
            } else {
                print("error: \(error?.localizedDescription)")
            }
        })
        view.addSubview(twitterLoginButton)
        // Add Constraints to Twitter Sign In Button
        twitterLoginButton.translatesAutoresizingMaskIntoConstraints = false
        twitterLoginButton.topAnchor.constraint(equalTo: googleSignInButton.topAnchor, constant: Defaults.buttonTopAnchor).isActive = true
        twitterLoginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Defaults.buttonLeadingAnchor).isActive = true
        twitterLoginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Defaults.buttonTrailingAnchor).isActive = true
    }
    
    // Fetch User's Public Facebook Profile Data
    func fetchUserProfileData() {
        let params = ["fields": "email, first_name, last_name, picture"]
        FBSDKGraphRequest(graphPath: "me", parameters: params).start(completionHandler: { connection, result, error in
            print(result.debugDescription)
        })
    }
    
    func showAlert(withTitle title: String, message: String) {
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertView.addAction(okAction)
        self.present(alertView, animated: true, completion: nil)
    }

}

// MARK: - Facebook SDK Button Delegates

extension ViewController: FBSDKLoginButtonDelegate {
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            showAlert(withTitle: "Error", message: "Something went wrong. Please try again!")
        } else if result.isCancelled {
            
        } else {
            showAlert(withTitle: "Success", message: "Successfully Logged in")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        showAlert(withTitle: "Success", message: "Successfully Logged out")
    }
}

// MARK: - Google Sign In Delgates

extension ViewController: GIDSignInUIDelegate {
    
}

extension ViewController: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        showAlert(withTitle: "Success", message: "Successfully Logged in \(user.userID)")
    }
    
    
}
