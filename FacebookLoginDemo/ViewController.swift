//
//  ViewController.swift
//  FacebookLoginDemo
//
//  Created by Praveenkumar on 7/27/18.
//  Copyright © 2018 Praveen Kumar. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKCoreKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userBirthday ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let accessToken = FBSDKAccessToken.current(), accessToken.tokenString.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                let alertController = UIAlertController.init(title: "User Logged In", message: "Yay, you've logged in already.", preferredStyle: .actionSheet)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print(result)
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
    }
}
