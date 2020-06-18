//
//  HomeController.swift
//  loginAppWithFB
//
//  Created by Hao Lam on 6/16/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//
//

import Foundation
import UIKit
import Firebase
class HomeController: UIViewController {

    @IBOutlet weak var welcome_label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfiregureView()
   
    }
  
    func authenticateUserAndConfiregureView()
    {
        //if user=nil => goto  login page
       // if Auth.auth().currentUser == nil
       // {
        //    DispatchQueue.main.async {
                
               // let navController = UINavigationController(rootViewController: LoginController())
                //navController.navigationBar.barStyle = .black
                //self.present(navController,animated: true, completion: nil)
        //        self.dismiss(animated: true, completion: nil)
        //        }
       // }
        //else
       // {
            print("HOME page - configure view component")
            configureViewComponents()
            print("load data")
            loadUserData()
        //}
    }
    
      func loadUserData()
      {
          guard let uid = Auth.auth().currentUser?.uid else
          {
              return
          }
          Database.database().reference().child("users").child(uid).child("username").observeSingleEvent(of: .value) { (snapshot) in
              guard let username = snapshot.value as? String else {return}
              print("username: \(username)")
              self.welcome_label.text = "Welcome \(username)"
          }
      }
    func configureViewComponents ()
    {
        view.backgroundColor = UIColor.brown
        navigationItem.title = "Firebase Login"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem (title: "Log Out", style: .plain, target: self, action: #selector(handle_signOut))
        
        
    }
    @objc func handle_signOut()
    {
        let alertController = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Sign Out", style:  .destructive, handler: { (_) in self.signOut()}))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController,animated: true, completion:  nil)
        
    }
    func signOut()
    {
        
              do {
                  try Auth.auth().signOut()
                 // let navController = UINavigationController(rootViewController: LoginController())
                 // navController.navigationBar.barStyle = .black
                // self.present(navController,animated: true, completion: nil)
                 navigationController?.popViewController(animated: true)
                
              }
              catch let error
              {
                  print ("Fail to sign out with ", error.localizedDescription)
              }
          
    }
}
