//
//  ProfileHeader.swift
//  CollectionViewProgrammatically
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class ProfileHeader:UICollectionReusableView
{
    
      let profileImageView: UIImageView = {
          let iv = UIImageView()
          iv.image = #imageLiteral(resourceName: "animals")
          iv.contentMode = .scaleAspectFill
          iv.clipsToBounds = true
          iv.layer.borderWidth = 3
          iv.layer.borderColor = UIColor.white.cgColor
          return iv
      }()
      
      let messageButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(#imageLiteral(resourceName: "message_icon").withRenderingMode(.alwaysOriginal), for: .normal)
          button.addTarget(self, action: #selector(handleMessageUser), for: .touchUpInside)
          return button
      }()
      
      let followButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(#imageLiteral(resourceName: "add_friend_icon").withRenderingMode(.alwaysOriginal), for: .normal)
          button.addTarget(self, action: #selector(handleFollowUser), for: .touchUpInside)
          return button
      }()
      
      let nameLabel: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.text = "Animal Collection"
          label.font = UIFont.boldSystemFont(ofSize: 26)
          label.textColor = .black
          return label
      }()
      
      let emailLabel: UILabel = {
          let label = UILabel()
          label.textAlignment = .center
          label.text = "animalworld@gmail.com"
          label.font = UIFont.systemFont(ofSize: 18)
          label.textColor = .black
          return label
      }()
    
     // MARK: - Selectors
    @objc func handleMessageUser() {
        print("Message user here..")
    }
    
    @objc func handleFollowUser() {
        print("Follow user here..")
    }
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        //set background color
        backgroundColor = .yellow
        
        //add profile image view to view
        addSubview(profileImageView)
        profileImageView.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        profileImageView.anchor(top: topAnchor, paddingTop: 88,width: 120, height: 120)
        profileImageView.layer.cornerRadius = 120 / 2
               
         //add message button view to view
        addSubview(messageButton)
               messageButton.anchor(top: topAnchor, left: leftAnchor,paddingTop: 64, paddingLeft: 32, width: 32, height: 32)
        
         //add follow button view to view
        addSubview(followButton)
        followButton.anchor(top: topAnchor, right: rightAnchor,paddingTop: 64, paddingRight: 32, width: 32, height: 32)
         //add name label view to view
        addSubview(nameLabel)
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.anchor(top: profileImageView.bottomAnchor, paddingTop: 12)
            
        //add email label view to view
        addSubview(emailLabel)
        emailLabel.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        emailLabel.anchor(top: nameLabel.bottomAnchor, paddingTop: 4)
               
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, paddingTop: CGFloat? = 0,
                paddingLeft: CGFloat? = 0, paddingBottom: CGFloat? = 0, paddingRight: CGFloat? = 0, width: CGFloat? = nil, height: CGFloat? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop!).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft!).isActive = true
        }
        
        if let bottom = bottom {
            if let paddingBottom = paddingBottom {
                bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
            }
        }
        
        if let right = right {
            if let paddingRight = paddingRight {
                rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
            }
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}


