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

    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email, .userBirthday ])
        loginButton.center = view.center
        loginButton.delegate = self
        
        view.addSubview(loginButton)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        fetchGraphValues()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Private Methods
    func fetchGraphValues() {
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil) {
                    if let resultDictionary = result as? [String : String] {
                        self.emailLabel.text = "Your Email: \( resultDictionary["email"]  ?? "")"
                    }
                }
            })
        }
    }

}

extension ViewController: LoginButtonDelegate {
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        self.fetchGraphValues()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        self.emailLabel.text = "Login with your Facebook account to Get your Email."
    }
}
