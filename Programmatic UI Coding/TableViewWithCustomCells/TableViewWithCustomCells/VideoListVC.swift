//
//  VideoListVC.swift
//  TableViewWithCustomCells
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class VideoListVC: UIViewController {
    //create table view
    var tableView = UITableView()
    var videos: [Video] = []
   
    struct Cells {
        static let videoCell = "VideCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Animal Videos"
        videos = fetchData()
        configureTableView()
    }
    
    func configureTableView()
    {
        view.addSubview(tableView)
        
        //set delegate
        setTV_delegate()
        //set height
        tableView.rowHeight = 100 
        //register cell
        tableView.register(VideoCellTableViewCell.self, forCellReuseIdentifier: Cells.videoCell)
        //set contraints
        tableView.pint(to: view)
    }
    func setTV_delegate()
    {
        tableView.delegate = self
        tableView.dataSource = self
    }


}
extension VideoListVC:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //how many rows
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //what cells
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.videoCell) as! VideoCellTableViewCell
        let video = videos[indexPath.row]
        cell.set(video: video)
        
        return cell
        
        
    }
    
    
}
extension UIView
{
    func pint(to superView:UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
//generating sample data
extension VideoListVC
{
    func fetchData()->[Video]
    {
        let video1 = Video(image: #imageLiteral(resourceName: "img1"), title:"dog")
        let video2 = Video(image: #imageLiteral(resourceName: "img2"), title:"cat")
        let video3 = Video(image: #imageLiteral(resourceName: "img3"), title:"elephant")
        let video4 = Video(image: #imageLiteral(resourceName: "img4"), title:"monkey")
        return [video1,video2,video3,video4]
        
    }
    
}
