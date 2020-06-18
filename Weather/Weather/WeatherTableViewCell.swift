//
//  WeatherTableViewCell.swift
//  Weather
//
//  Created by Hao Lam on 6/15/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
 
    @IBOutlet weak var day_label: UILabel!
    
    @IBOutlet weak var temp_label: UILabel!
    
    @IBOutlet weak var weather_img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    //register cell
       static let identifier = "WeatherTableViewCell"
       static func nib() -> UINib{
           return UINib(nibName: "WeatherTableViewCell", bundle: nil)
       }
}
