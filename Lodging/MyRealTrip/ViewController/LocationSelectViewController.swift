//
//  LocationSelectViewController.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 22..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit

class LocationSelectViewController: UIViewController {
    
    @IBOutlet weak var locationSelectTextField: UITextField!
    @IBOutlet weak var locationSelectCancelButton: UIButton!
    @IBOutlet weak var locationSelectTableView: UITableView!
    
    var locationArr: [String] = ["오사카", "후쿠오카", "라스베가스", "도쿄", "로마", "타이페이"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationSelectCancelButton.setTitle("취소", for: .normal)
        locationSelectCancelButton.setTitleColor(UIColor.black, for: .normal)
        
        //TableView Delegate, Datasource
        locationSelectTableView.delegate = self
        locationSelectTableView.dataSource = self
        
        //Xib Register
        let nibName = UINib(nibName: "LocationSelectTableViewCell", bundle: nil)
        locationSelectTableView.register(nibName, forCellReuseIdentifier: "LocationSelectCell")
        
    }
    
    @IBAction func didTapLocationSelectCancelButton(_ sender: UIButton) {
        print("did Tap Location Select Cancel Button")
        dismiss(animated: true)
        
    }
}

extension LocationSelectViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "인기 여행지"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LocationSelectCell", for: indexPath) as! LocationSelectTableViewCell
        
        cell.locationSelectXibLabel.text = locationArr[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did Select Row At")
        
        //Notification Post Location Data
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "locationData"), object: nil, userInfo: ["select": locationArr[indexPath.row]])
        
        self.dismiss(animated: true)
    }
}
