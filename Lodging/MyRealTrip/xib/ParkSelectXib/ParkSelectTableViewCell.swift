//
//  ParkSelectTableViewCell.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 22..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit

class ParkSelectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImage.layer.cornerRadius = 5
        thumbnailImage.layer.masksToBounds = true
        
        reviewCountLabel.textColor = UIColor.darkGray
        reviewCountLabel.font = UIFont.boldSystemFont(ofSize: 10)
        
        parkNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        priceLabel.font = UIFont.boldSystemFont(ofSize: 12)
        priceLabel.textAlignment = .right
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
