//
//  ProfileCell.swift
//  CollectionViewProgrammatically
//
//  Created by Hao Lam on 7/1/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class ProfileCell: UICollectionViewCell
{
    var image: UIImage?{
        //passing image from controller to cell
        didSet
        {
            guard let image = image else {return}
            cellImageView.image = image
        }
    }
    let cellImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "img10")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(cellImageView)
        cellImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
