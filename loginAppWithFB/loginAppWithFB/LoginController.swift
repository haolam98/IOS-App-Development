//
//  LoginController.swift
//  loginAppWithFB
//
//  Created by Hao Lam on 6/16/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin
import FBSDKLoginKit
import Firebase
import FirebaseAuth


class LoginController: UIViewController {

    var username = String()
    var user_email = String()
    
    @IBOutlet weak var user_email_text: UITextField!
  
    @IBOutlet weak var password_text: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

      //let loginButton = FBLoginButton()
       // loginButton.center = view.center; view.addSubview(loginButton)
       

    }

    @IBAction func didTapped_withFB(_ sender: Any) {
        FBlogin()
    }
    
    @IBAction func didTapped_login(_ sender: Any) {
        // check if empty
        guard let password = password_text.text, !password.isEmpty else{return}
        guard let email = user_email_text.text, !email.isEmpty else{return}
        login(withEmail: email, password: password)
        print("Sucessfully log user in")
        let vc = storyboard?.instantiateViewController(identifier: "home") as! HomeController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapped_signup(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(identifier: "signup") as! SignupController
               vc.title = "Sign Up"
         navigationController?.pushViewController(vc, animated: true)
    }
    
    func login(withEmail email: String, password: String)
    {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
        if let error = error
        {// error handling
            print("Fail to login user with error: ", error.localizedDescription)
            return
        }
                      //get user id
           
         //  guard let navController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else {return}
         //   guard let controller = navController.viewControllers[0] as? HomeController else { return}
          //  controller.configureViewComponents()

           
            // dismiss controller
           //self.dismiss(animated: true, completion: nil)
        }
    }
    
    func FBlogin()
    {
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.publicProfile, .email, .userFriends], viewController: self)
        {
            loginResult in
            switch loginResult
            {
            case .failed(let error):
               // HUD.hide()
                print(error)
                
            case .cancelled:
              //  HUD.hide()
                print("User canceled login")
                
            case .success( _, _, _):
                print("Logged in")
                self.getFBUserData()
                if let accessToken = AccessToken.current
                {
                    self.firebaseFB_login(accessToken: accessToken.tokenString)
                    let vc = self.storyboard?.instantiateViewController(identifier: "home") as! HomeController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    func firebaseFB_login(accessToken:String)
    {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error = error
            {// error handling
                print("Fail to login user with error: ", error.localizedDescription)
                return
            }
            //user has sign in
            print ("Firebase FB Login: DONE")
            print(result)
            if let user = Auth.auth().currentUser
            {
                print ("Current FB User is \(user)")
            }
        }
    }
    func getFBUserData()
    {
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email, gender"]).start(completionHandler: {
            (connection, result, error) -> Void in
            
            if (error == nil)
            {
                let dict = result as! [String : AnyObject]
                print(result!)
                print (dict)
                
                let pictureDic = dict as NSDictionary
                let tmpURL1 = pictureDic.object(forKey: "picture") as! NSDictionary
                let tmpURL2 = tmpURL1.object(forKey: "data") as! NSDictionary
                let finalURL = tmpURL2.object(forKey: "url") as! String
                
                let nameOfUser = pictureDic.object(forKey: "name") as! String
                self.username = nameOfUser
                
                var tmpEmailAdd = ""
                if let emailAddress = pictureDic.object(forKey: "email")
                {
                    tmpEmailAdd = emailAddress as! String
                    self.user_email = tmpEmailAdd
                }
                
                
            }
        })
    }
}
