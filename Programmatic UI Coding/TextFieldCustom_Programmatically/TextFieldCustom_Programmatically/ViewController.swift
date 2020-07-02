//
//  ViewController.swift
//  TextFieldCustom_Programmatically
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let username = UITextField (frame: CGRect(x:10, y:320, width: 300.00, height: 30.00));
     let password = UITextField (frame: CGRect(x:10, y:360, width: 300.00, height: 30.00));
    override func viewDidLoad() {
        super.viewDidLoad()
        displayLoginFields()
        
    }
    func displayLoginFields()
    {
        // add username text field
        username.placeholder = "Username"
        username.borderStyle = UITextField.BorderStyle.line
        username.backgroundColor = UIColor.white
        username.textColor = UIColor.red
        
        
        
        //add password text field
        password.placeholder = "password"
        password.borderStyle = UITextField.BorderStyle.line
        password.isSecureTextEntry = true
        password.backgroundColor = UIColor.white
        password.textColor = UIColor.blue
        self.view.addSubview(username)
        
        //add to subview
        
        self.view.addSubview(username)
        self.view.addSubview(password)
    }

}

