//
//  SignupController.swift
//  loginAppWithFB
//
//  Created by Hao Lam on 6/16/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import Foundation
import UIKit
import Firebase
class SignupController: UIViewController {

    @IBOutlet weak var email_textField: UITextField!
    
    @IBOutlet weak var username_text_field: UITextField!
    
    @IBOutlet weak var password_textfield: UITextField!
    
override func viewDidLoad() {
    super.viewDidLoad()
    
    //create a button at right corner by code
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Up", style: .done, target: self, action: #selector(sign_up))
    
    }
    @objc func sign_up() // @objc means allow tp use as selector above
    {
        guard let email = email_textField.text else {return}
        guard let username = username_text_field.text else {return}
        guard let password = password_textfield.text else {return}
        
        createUser(withEmail: email, password: password, username: username)
        navigationController?.popViewController(animated: true)
    }
    
    func createUser(withEmail email:String, password:String, username:String)
    {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            
            if let error = error
            {// error handling
                print("Fail to signup user with error: ", error.localizedDescription)
                return
            }
            //get user id
            guard let uid = result?.user.uid else
            {// automatically generate user id
                return
            }
            
            let values = ["email": email, "username": username]
            Database.database().reference().child("users").child(uid).updateChildValues(values, withCompletionBlock: { (error, ref) in
                if let error = error
                {// error handling
                    print("Fail to update database values with error: ", error.localizedDescription)
                    return
                }
                //if sucessfully signup user
                print ("Successfully signed user up")
                //goto Home
                
            })
        }
    }
    
    
}

