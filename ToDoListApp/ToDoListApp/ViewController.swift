//
//  ViewController.swift
//  ToDoListApp
//
//  Created by Hao Lam on 6/16/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var total_done_label: UILabel!
    @IBOutlet weak var total_count_label: UILabel!
    var tasks = [String]()
    var isdone_status = [Int]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "My Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
       
       //initial total_done & total_count = 0
              total_count_label.text = String(0)
              total_done_label.text = String(0)
        
        //setup saving mechanism
        setup_savin_mec()
        updateTasks()
       
    }
    override func viewDidDisappear(_ animated: Bool) {
         UserDefaults().set(isdone_status, forKey: "isdone_status")
    }
    func setup_savin_mec()
    {
        if !UserDefaults().bool(forKey: "setup") // if it does not setup yet => do one
               {
                   UserDefaults().set(true, forKey: "setup") // set to true so that it will not do mulitple times.
                   
                   UserDefaults().set(0, forKey: "count")
                   UserDefaults().set(tasks, forKey: "task_list")
                  
               }
    }
    // re-create the task array
    func updateTasks()
    {
        //tasks.removeAll() //empty the list
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {//mean make sure it not empty
            return
        }
        /* Not efficent (cannot delete) than pushing entire array to User Defaul =>
        for x in 0..<count
        {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String
            {
                // if not empty, add to list
                tasks.append(task)
            }
        }*/
        guard let array2 = UserDefaults().object(forKey: "isdone_status") as? [Int] else {return}
        guard let array = UserDefaults().object(forKey: "task_list") as? [String] else {return}
        
        tasks = array
        isdone_status = array2
        print ("update List: tasks_count: \(tasks.count)")
        print ("update List: isDone_status_count: \(isdone_status.count)")
        reload_layout(count, isdone_status.count)
        
      
    }
    func reload_layout(_ tasks_count:Int, _ isDone_count:Int)
    {
        //reset total
        self.total_count_label.text = String(tasks_count)
        self.total_done_label.text = String(isDone_count)
        //reload table view
        tableView.reloadData()
        
    }
    @IBAction func didTapped_Add(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        
        vc.update = {
            DispatchQueue.main.async
            {// making sure the update function is priortize
                self.updateTasks()
            }
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func didTapped_Reset(_ sender: Any) {
    
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
            dictionary.keys.forEach
                { key in
                defaults.removeObject(forKey: key)
                }
        //update
        UserDefaults().set(false, forKey: "setup")
        reset_setting()
        setup_savin_mec()
    }
    func reset_setting()
    {
        tasks.removeAll()
        isdone_status.removeAll()
        self.total_done_label.text = String(0)
        self.total_count_label.text = String(0)
        tableView.reloadData()
     
    }
    
}
extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // when item is selected, un-highlight the item
        tableView.deselectRow(at: indexPath, animated: true)
        
        //delete item
        let vc = storyboard?.instantiateViewController(identifier: "display_task") as! DisplayTasksViewController
               vc.title = "My Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("table view: count: \(tasks.count)")
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        
        //switch button
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(task_status), for: .valueChanged)
        mySwitch.tag = indexPath.row
        
        if (isdone_status.contains(indexPath.row))
        {
            mySwitch.setOn(true, animated: true)
        }
        cell.accessoryView = mySwitch
        return cell
    }
    //Swipe right action button
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let delete = deleteAction(at: indexPath)
       
        let config = UISwipeActionsConfiguration(actions: [delete]) // if more UIContextualAction, add them to array
        
        config.performsFirstActionWithFullSwipe = false; // not fully swipe to get the action.
        
        return config
        
    }
    func deleteAction(at indexPath: IndexPath) -> UIContextualAction
    {
        
        // style .destructive is default to red, .normal = gray
        let action = UIContextualAction(style: .destructive, title: "Delete")
        { (action,view,completion)  in
               
             print ("Delete row: \(indexPath.row)")
             
            //update task list & isDone_status list & //update label //update user defaults
            self.tasks.remove(at: indexPath.row)
            self.total_count_label.text = String(self.tasks.count)
            UserDefaults().set(self.tasks, forKey: "task_list")
            UserDefaults().set(self.tasks.count, forKey: "count")
            if ( self.isdone_status.contains(indexPath.row))
            {
                self.isdone_status = self.isdone_status.filter {$0 != indexPath.row}
                self.total_done_label.text = String (self.isdone_status.count)
                UserDefaults().set(self.isdone_status, forKey: "isdone_status")
            }
            
            
            
            
            //delete cell in table
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
             completion(true)
        }
        
        //add background
        action.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1) //type color literal to choose color
        action.image = #imageLiteral(resourceName: "trash_can") // type image literal
        
        
        return action
               
        
    }
    @objc func task_status(_ sender:UISwitch)
    {
        if sender.isOn
        {
            print("Switch: done -task: \(sender.tag)")
            //update label
            let total_done = isdone_status.count + 1
            total_done_label.text = String (total_done)
            isdone_status.append(sender.tag) // add switch to list
        }
        else
        {
             print("Switch: undone -task: \(sender.tag)")
            //update label
            let total_done = isdone_status.count - 1
            total_done_label.text = String (total_done)
            if (isdone_status.contains(sender.tag))
            {
                //remove switch out of the list
                print ("Undone task: \(sender.tag)")
                isdone_status = isdone_status.filter {$0 != sender.tag}
               
            }
            
        }
    }
}
