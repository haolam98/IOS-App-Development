//
//  DisplayTasksViewController.swift
//  ToDoListApp
//
//  Created by Hao Lam on 6/16/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class DisplayTasksViewController: UIViewController {

    @IBOutlet var label :UILabel!
    var task: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .done, target: self, action: #selector(deleteTask))
    }
    
    @objc func deleteTask()
    {
       // let newCount = count -1
       // UserDefaults().setValue(newCount, forKey: "count") // decrement count
       // UserDefaults().setValue(nil, forKey: "task_\(currentPosition)") // set current to nil
    }

  

}
