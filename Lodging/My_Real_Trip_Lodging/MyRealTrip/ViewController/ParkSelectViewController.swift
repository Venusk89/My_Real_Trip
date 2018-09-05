//
//  ParkSelectViewController.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 22..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class TableViewCellCountData {
    static let data = TableViewCellCountData()
    var count: Int = 0
    private init() {
        
    }
    struct Location {
        var country: String
        var city: String
    }
}

class ParkSelectViewController: UIViewController {
    
    var count = 0
    
    struct Park: Codable {
        var pk: Int
        var name: String
        var city: Int
        var country: Int
        var thumbnail: String
        var comments: String
        var price: String
    }
    let decoder = JSONDecoder()
    var jsonArr: [Park] = []
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var parkSelectLabel: UILabel!
    @IBOutlet weak var parkTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setTitle("뒤로", for: .normal)
        parkSelectLabel.text = "한인민박"
        parkSelectLabel.textColor = UIColor.black
        
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        let url = singletonData.url
        
        Alamofire.request(url, method: .get)
            .validate()
            .responseData
            { (response) in
                
                switch response.result {
                case .success(let value):
                    do {
                        let decode = try self.decoder.decode([Park].self, from: value)
                        print(decode[0])
                        let taleViewCount: TableViewCellCountData = TableViewCellCountData.data
                        taleViewCount.count = decode.count
                        self.jsonArr = decode
                        self.parkTableView.reloadData()
                    } catch {
                        print("Error")
                    }
                case .failure(let error):
                    print(error)
                }
        }
        
        //TableView Delegate, Datasource
        parkTableView.delegate = self
        parkTableView.dataSource = self
        
        //Xib Register
        let nibName = UINib(nibName: "ParkSelectTableViewCell", bundle: nil)
        parkTableView.register(nibName, forCellReuseIdentifier: "ParkSelectCell")
    }
    
    
    @IBAction func didTapBackButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    deinit {
        TableViewCellCountData.data.count = 0
    }
}


extension ParkSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableViewCellCountData.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ParkSelectCell", for: indexPath) as! ParkSelectTableViewCell
        
//        print(jsonArr)
        
        cell.parkNameLabel.text = jsonArr[indexPath.row].name
        cell.priceLabel.text = jsonArr[indexPath.row].price
        cell.reviewCountLabel.text = jsonArr[indexPath.row].comments
        let jsonUrl = URL(string: jsonArr[indexPath.row].thumbnail)
        cell.thumbnailImage.kf.setImage(with: jsonUrl)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did Select Row At")
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkDetailViewController")
        present(viewController, animated: true, completion: nil)
        
    }
    
}

