//
//  ViewController.swift
//  AutoLayout
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //{} is refered to as closure, or anon.fucntions
    let bear_iv: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "bear"))
        //enable autolayout for imageview
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //make sure the height+ width stay the same regardless the size of image view
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let topImageContainerView: UIView = {
        let view = UIView()
        //enable autolayout for imageview
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .blue
        
        return view
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        //able to modify texts with attribute text
        let attributedText = NSMutableAttributedString(string: "Join Teddy Club with us today", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        
        attributedText.append(NSAttributedString(string: "\n\nAre you ready to have a lot of fun with Teddy? Don't let Teddy wait for too long. Hope to see you soon", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.red]))
        
        textView.attributedText = attributedText
//        textView.text = "Join Teddy Club with us today"
//        textView.font = UIFont.boldSystemFont(ofSize: 18)
        
        //enable autolayout for imageview
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false // cannot fix text on-screen
        textView.isScrollEnabled = false
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        //Add subview to view
        view.addSubview(descriptionTextView)
        view.addSubview(topImageContainerView)
        //set up topImageContainerView layout
        setup_topContainerView_constraints()
        
        //Add bear image to topImageContainerView
        topImageContainerView.addSubview(bear_iv)
        //set up image view layout
        setup_iv_constraints()
        //set up text view layout
        setup_tf_constraints()
    }
    func setup_topContainerView_constraints()
    {
        //topImageContainerView.frame = CGRect(x:0,y:0, width:100, height:100)
        //enable auto layout
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        //left anchor
           //topImageContainerView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        //right acchor
           //topImageContainerView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        // using leading and trailing instead
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    func setup_iv_constraints()
    {
         //SET IMAGE constraints
         //imageView.frame = CGRect(x:0, y: 0, width: 50, height: 50)
         //center horrizonally
         bear_iv.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
         //center vertically
         bear_iv.centerYAnchor.constraint(equalTo: topImageContainerView.centerYAnchor).isActive = true
        
         // top anchor
         //bear_iv.topAnchor.constraint(equalTo:view.topAnchor, constant: 100).isActive = true
         //specify width + height
        // bear_iv.widthAnchor.constraint(equalToConstant: 200).isActive = true
        bear_iv.heightAnchor.constraint(equalTo: topImageContainerView.heightAnchor, multiplier:  0.5).isActive = true
    }
    func setup_tf_constraints()
    {
        // top anchor of text is bottom of bear_iv
        descriptionTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 20).isActive = true
        
        //left anchor : between margin <-> text : 14
        descriptionTextView.leftAnchor.constraint(equalTo:view.leftAnchor, constant: 14).isActive = true
        //right acchor : between margin <-> text : 14
        descriptionTextView.rightAnchor.constraint(equalTo:view.rightAnchor, constant: -14).isActive = true
        //bottom anchor
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }

}

