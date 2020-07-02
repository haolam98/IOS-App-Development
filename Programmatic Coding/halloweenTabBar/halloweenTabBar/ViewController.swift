//
//  ViewController.swift
//  halloweenTabBar
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit
import TinyConstraints
class ViewController: UIViewController {
    
    var image:UIImage?
    
    //imageView
    lazy var imageView: UIImageView = {
        var iv = UIImageView()
        if let image = image{
        iv.image = image
        }
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //add background
        view.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        //add image view
        view.addSubview(imageView)
        imageView.centerInSuperview()
        imageView.width(view.frame.width*0.6)
        imageView.height (view.frame.height*0.6)
    }


}

