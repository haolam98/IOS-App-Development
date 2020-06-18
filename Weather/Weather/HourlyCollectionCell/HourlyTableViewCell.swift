//
//  HourlyTableViewCell.swift
//  Weather
//
//  Created by Hao Lam on 6/15/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //register cell
    static let identifier = "HourlyTableViewCell"
    static func nib() -> UINib{
        return UINib(nibName: "HourlyTableViewCell", bundle: nil)
    }
}
