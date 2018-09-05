//
//  HotelPopularCollectionViewCell.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 23..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit

class HotelPopularCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var hotelPopularImage: UIImageView!
    
    @IBOutlet weak var hotelPopularName: UILabel!
    
    @IBOutlet weak var hotelPopularPrice: UILabel!
    
    @IBOutlet weak var hotelPopularGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        hotelPopularImage.layer.cornerRadius = 5
        hotelPopularImage.layer.masksToBounds = true
        
        hotelPopularName.font = UIFont.boldSystemFont(ofSize: 15)
        
        hotelPopularPrice.textColor = UIColor.darkGray
        hotelPopularPrice.font = UIFont.boldSystemFont(ofSize: 12)
        
        hotelPopularGrade.textColor = UIColor.white
        hotelPopularGrade.backgroundColor = UIColor.gray
        hotelPopularGrade.layer.cornerRadius = 5
        hotelPopularGrade.layer.masksToBounds = true
        hotelPopularGrade.textAlignment = .center
        hotelPopularGrade.font = UIFont.boldSystemFont(ofSize: 20)
        
        
    }

}
