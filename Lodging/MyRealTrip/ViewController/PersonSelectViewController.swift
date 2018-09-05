//
//  PersonSelectViewController.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 22..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit

class PersonSelectViewController: UIViewController {
    
    @IBOutlet weak var personSelectView: UIView!
    @IBOutlet weak var backGroundButton: UIButton!
    @IBOutlet weak var adultNumber: UILabel!
    @IBOutlet weak var kidNumber: UILabel!
    @IBOutlet weak var roomNumber: UILabel!
    @IBOutlet weak var adultAddButton: UIButton!
    @IBOutlet weak var adultMinusButton: UIButton!
    @IBOutlet weak var kidAddButton: UIButton!
    @IBOutlet weak var kidMinusButton: UIButton!
    @IBOutlet weak var roomAddButton: UIButton!
    @IBOutlet weak var roomMinusButton: UIButton!
    @IBOutlet weak var selectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personSelectView.layer.cornerRadius = 10
        personSelectView.layer.masksToBounds = true
        selectButton.layer.cornerRadius = 10
        selectButton.layer.masksToBounds = true
        
        adultNumber.text = "2"
        roomNumber.text = "1"
        kidNumber.text = "0"
        kidMinusButton.isEnabled = false
        
    }
    
    
    @IBAction func didTapBackGroundButton(_ sender: UIButton) {
        print("did Tap BackGrond Button")
        dismiss(animated: true)
    }
    @IBAction func didTapAdultAddButton(_ sender: UIButton) {
        print("did Tap Adult Add Button")
        if 10 > Int(adultNumber.text!)! || Int(adultNumber.text!)! > 0 {
            adultMinusButton.isEnabled = true
            let adult = Int(adultNumber.text!)! + 1
            adultNumber.text = "\(adult)"
        } else { return }
    }
    
    @IBAction func didTapAdultMinusButton(_ sender: UIButton) {
        print("did Tap Adult Minus Button")
        if Int(adultNumber.text!)! > 1 {
            let adult = Int(adultNumber.text!)! - 1
            adultNumber.text = "\(adult)"
        } else {
            let adult = Int(adultNumber.text!)! - 1
            adultNumber.text = "\(adult)"
            adultMinusButton.isEnabled = false
            return }
    }
    
    @IBAction func didTapKidAddButton(_ sender: UIButton) {
        print("did Tap Kid Add Button")
        if 10 > Int(kidNumber.text!)! || Int(kidNumber.text!)! > 0 {
            kidMinusButton.isEnabled = true
            let kid = Int(kidNumber.text!)! + 1
            kidNumber.text = "\(kid)"
        } else { return }
    }
    
    @IBAction func didTapKidMinusButton(_ sender: UIButton) {
        print("did Tap Kid Minus Button")
        if Int(kidNumber.text!)! > 1 {
            let kid = Int(kidNumber.text!)! - 1
            kidNumber.text = "\(kid)"
        } else { let kid = Int(kidNumber.text!)! - 1
            kidNumber.text = "\(kid)"
            kidMinusButton.isEnabled = false
            return }
    }
    
    @IBAction func didTapRoomAddButton(_ sender: UIButton) {
        print("did Tap Room Add Button")
        if 10 > Int(roomNumber.text!)! || Int(roomNumber.text!)! > 0 {
            roomMinusButton.isEnabled = true
            let room = Int(roomNumber.text!)! + 1
            roomNumber.text = "\(room)"
        } else { return }
    }
    
    @IBAction func didTapRoomMinusButton(_ sender: UIButton) {
        print("did Tap Room Minus Button")
        if Int(roomNumber.text!)! > 1 {
            let room = Int(roomNumber.text!)! - 1
            roomNumber.text = "\(room)"
        } else { let room = Int(roomNumber.text!)! - 1
            roomNumber.text = "\(room)"
            roomMinusButton.isEnabled = false
            return }
    }
    
    @IBAction func didTapSelectButton(_ sender: UIButton) {
        print("did Tap Select Button")
        
        guard let adultNumber = adultNumber.text else { return }
        guard let kidNumber = kidNumber.text else { return }
        guard let roomNumber = roomNumber.text else { return }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "personData"), object: nil, userInfo: ["adult": adultNumber, "kid": kidNumber, "room": roomNumber])
        
        dismiss(animated: true) {
            print("Dismiss")
        }
    }
}
