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
    var total_done = 0
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "My Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        //setup saving mechanism
        setup_savin_mec()
       
        updateTasks()
        //initial total_done to 0
        total_done_label.text = String(0)
    }
    
    func setup_savin_mec()
    {
        if !UserDefaults().bool(forKey: "setup") // if it does not setup yet => do one
               {
                   UserDefaults().set(true, forKey: "setup") // set to true so that it will not do mulitple times.
                   
                   UserDefaults().set(0, forKey: "count")
                   
               }
    }
    // re-create the task array
    func updateTasks()
    {
        tasks.removeAll() //empty the list
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else
        {//mean make sure it not empty
            return
        }
        
        for x in 0..<count
        {
            if let task = UserDefaults().value(forKey: "task_\(x+1)") as? String
            {
                // if not empty, add to list
                tasks.append(task)
            }
        }
        reload_layout(count)
      
    }
    func reload_layout(_ count:Int)
    {
        //reload table view
              tableView.reloadData()
              //reset total
              self.total_count_label.text = String(count)
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
        tableView.reloadData()
        self.total_done_label.text = String(0)
        self.total_count_label.text = String(0)
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
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        let mySwitch = UISwitch()
        mySwitch.addTarget(self, action: #selector(task_status), for: .valueChanged)
        cell.accessoryView = mySwitch
        return cell
    }
    @objc func task_status(_ sender:UISwitch)
    {
        if sender.isOn
        {
            print("task done")
            //update label
            total_done = total_done + 1
            total_done_label.text = String (total_done)
        }
        else
        {
             print("task undone")
            //update label
            total_done = total_done - 1
            total_done_label.text = String (total_done)
        }
    }
}
