//
//  ParkDetailViewController.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 22..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher


// BackEnd Api 미완성

class ParkDetailViewController: UIViewController {
    struct Park: Codable {
        var pk: Int
        var koreanHotel: Int
        var pictures: String
        var infos: String
        
        enum CodingKeys: String, CodingKey {
            case pk
            case koreanHotel = "korean_hotel"
            case pictures
            case infos
        }
    }
//    var urlArr = []
    
    let decoder = JSONDecoder()
    
    @IBOutlet private weak var parkDetailScrollView: UIScrollView!
    @IBOutlet private weak var parkDetailStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Spain/Madrid/28/"
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseData { (response) in
                switch response.result {
                case .success(let value):
                    do {
                        let decode = try self.decoder.decode([Park].self, from: value)
                        print(decode[0].pictures)
                        let a = decode[0].pictures.prefix(5)
                        print(a)
                        print(type(of: a))
                        
//                        self.urlArr = decode[0].pictures
//                        print(self.urlArr[0])
                        self.parkDetailStackView.reloadInputViews()
                    } catch {
                        print("Error")
                    }
                case .failure(let error):
                    print(error)
                    
                }
        }
        
        let index = parkDetailStackView.arrangedSubviews.count - 1
        let addView = parkDetailStackView.arrangedSubviews[index]
        
        for i in 1...10 {
            let newView = createEntry()
            parkDetailStackView.addArrangedSubview(newView)
        }
        
        
    }
    
    @objc func createEntry() -> UIView {
        
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .firstBaseline
        stack.distribution = .fill
        stack.spacing = 8
        
        let imageView = UIImageView()
       imageView.image = #imageLiteral(resourceName: "Lodging")
        
        
        stack.addArrangedSubview(imageView)
        
        
        return stack
    }
    
    
}


