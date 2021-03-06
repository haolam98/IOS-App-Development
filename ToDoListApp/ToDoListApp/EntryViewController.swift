//
//  EntryViewController.swift
//  ToDoListApp
//
//  Created by Hao Lam on 6/16/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController , UITextFieldDelegate, UITextViewDelegate{
    
    var update: (()-> Void)?
    @IBOutlet weak var field: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //when user hit enter -> save
        field.delegate = self
        
        //create a button at right corner by code
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        return true
    }
    @objc func saveTask() // @objc means allow tp use as selector above
    {
        // check if empty
        guard let text = field.text, !text.isEmpty else
       {
            return
        }
        // save task -> User Default
        guard let count = UserDefaults().value(forKey: "count") as? Int else {return}
       // guard var array = UserDefaults().object(forKey: "task_list") as? [String] else {
            // if task_list is empty
                        
        //}
        var array = UserDefaults().object(forKey: "task_list") as! [String]
        let newCount = count + 1
        UserDefaults().set(newCount, forKey: "count")
        
        print ("**before: \(array.count)")
        array.append(text) // add new task to array
        print ("**after: \(array.count)")
        for item in array
        {
            print (item)
        }
        
        UserDefaults().set(array, forKey: "task_list")
        //UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?() //means if the update funct exist, call it
        
        //dismiss view controller
        navigationController?.popViewController(animated: true)
    }

}
