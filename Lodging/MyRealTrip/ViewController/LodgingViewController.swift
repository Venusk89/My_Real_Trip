//
//  LodgingViewController.swift
//  MyRealTrip
//
//  Created by H on 2018. 8. 21..
//  Copyright © 2018년 sanghyuk. All rights reserved.
//

import UIKit
import Alamofire
import CalendarDateRangePickerViewController
import Kingfisher
import ParallaxHeader
import SafariServices

class SingletonUrlData {
    static let data = SingletonUrlData()
    var url: String = ""
    private init() {
        
    }
}
struct Hotel {
    var locationName: String = "여행지 또는 숙소명"
    struct calender {
        var month: Int
        var day: Int
    }
    struct Person {
        var adult: Int = 2
        var kid: Int = 0
        var room: Int = 1
    }
}

struct ParkLocation {
    var fisrt: String = "오사카"
    var second: String = "로마"
    var thrid: String = "런던"
    var fourth: String = "파리"
    var fifth: String = "바르셀로나"
    var sixth: String = "프라하"
    var seventh: String = "로스엔젤레스"
    var eight: String = "마드리드"
    var ninth: String = "피렌체"
}
class LodgingViewController: UIViewController {
    
    
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var hotelButton: UIButton!
    @IBOutlet weak var parkButton: UIButton!
    @IBOutlet weak var buttonUnderBar: UIView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var hotelButtonView: UIView!
    @IBOutlet weak var hotelLocationButtonView: UIView!
    @IBOutlet weak var hotelLocationLabel: UILabel!
    @IBOutlet weak var hotelLocationButton: UIButton!
    @IBOutlet weak var hotelCalenderButtonView: UIView!
    @IBOutlet weak var hotelCalenderLabel: UILabel!
    @IBOutlet weak var hotelCalenderButton: UIButton!
    @IBOutlet weak var hotelPersonButtonView: UIView!
    @IBOutlet weak var hotelPersonLabel: UILabel!
    @IBOutlet weak var hotelPersonButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var BannerButton: UIButton!
    @IBOutlet weak var parkButtonView: UIView!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    @IBOutlet weak var fifthButton: UIButton!
    @IBOutlet weak var sixthButton: UIButton!
    @IBOutlet weak var seventhButton: UIButton!
    @IBOutlet weak var eighthButton: UIButton!
    @IBOutlet weak var ninthButton: UIButton!
    
    @IBOutlet weak var hotelPopularView: UIView!
    @IBOutlet weak var hotelPopularFisrtButton: UIButton!
    @IBOutlet weak var hotelPopularSecondButton: UIButton!
    @IBOutlet weak var hotelPopularCollectionView: UICollectionView!
    @IBOutlet weak var hotelPopularThirdButton: UIButton!
    @IBOutlet weak var hotelPopularFourthButton: UIButton!
    @IBOutlet weak var hotelPopularFifthButton: UIButton!
    @IBOutlet weak var hotelPopularSixthButton: UIButton!
    
    var searchButtonValue: Int = 0
    
    // Codable
    
    struct HotelPopular: Codable {
        var pk: Int
        var city: Int
        var country: Int
        var thumbnail: String
        var hotelName: String
        var grade: String
        var comments: String
        var price: String
        
        enum CodingKeys: String, CodingKey {
            case pk
            case city
            case country
            case thumbnail
            case hotelName = "hotel_name"
            case grade
            case comments
            case price
        }
        
    }
    
    let decoder = JSONDecoder()
    var hotelPopularArr: [HotelPopular] = []
    var country = "Japan"
    var city = "Osaka"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Main Image Set up
        mainImage.image = #imageLiteral(resourceName: "Hotel")
        
        //View Container Set up
        self.viewContainer.bringSubview(toFront: hotelButtonView)
        viewContainer.layer.cornerRadius = 5
        viewContainer.layer.masksToBounds = true
//        viewContainer.layer.shadowColor = UIColor.gray.cgColor
//        viewContainer.layer.shadowOpacity = 5
//        viewContainer.layer.shadowOffset = CGSize.zero
//        viewContainer.layer.shadowRadius = 10
//        viewContainer.layer.shadowPath = UIBezierPath(rect: viewContainer.bounds).cgPath
//        viewContainer.layer.shouldRasterize = true
        viewContainer.layer.borderWidth = 0.5
        viewContainer.layer.backgroundColor = UIColor.lightGray.cgColor
        
        //Hotel Park Button Set up
        hotelButton.setTitle("호텔", for: .normal)
        hotelButton.setTitleColor(UIColor.white, for: .normal)
        hotelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        parkButton.setTitle("한인민박", for: .normal)
        parkButton.setTitleColor(UIColor.white, for: .normal)
        parkButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        //HotelButtonView
        
        hotelLocationButton.setTitle("", for: .normal)
        hotelCalenderButton.setTitle("", for: .normal)
        hotelPersonButton.setTitle("", for: .normal)
        
        // Button Under Bar Set up
        
        buttonUnderBar.frame = CGRect(x: 78, y: 117, width: 110, height: 5)
        buttonUnderBar.backgroundColor = UIColor.white
        buttonUnderBar.layer.cornerRadius = 3
        buttonUnderBar.layer.masksToBounds = true
        
    
        //Banner Button
        
//        BannerButton.setImage(#imageLiteral(resourceName: "Banner"), for: .normal)
        
        //Date
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        guard let year =  components.year,
            let month = components.month,
            let day = components.day
            else { return }
        
        var hotelLocationText = Hotel.init(locationName: "여행지 또는 숙소명")
        var hotelCalenderText = Hotel.calender.init(month: month, day: day)
        var hotelPersonText = Hotel.Person.init(adult: 2, kid: 0, room: 1)
        
        hotelLocationLabel.text = hotelLocationText.locationName
        hotelCalenderLabel.text = "\(hotelCalenderText.month)월\(hotelCalenderText.day) -  \(hotelCalenderText.month)월\(hotelCalenderText.day + 1)일"
        hotelPersonLabel.text = "성인\(hotelPersonText.adult), 어린이\(hotelPersonText.kid) / 객실\(hotelPersonText.room)"
        
        //ParkButtonView
        
        var parkButtonNumber = ParkLocation.init(fisrt: "오사카", second: "로마", thrid: "런던", fourth: "파리", fifth: "바르셀로나", sixth: "프라하", seventh: "로스엔젤레스", eight: "마드리드", ninth: "피렌체")
        
        firstButton.setTitle(parkButtonNumber.fisrt, for: .normal)
        firstButton.setTitleColor(UIColor.black, for: .normal)
        secondButton.setTitle(parkButtonNumber.second, for: .normal)
        secondButton.setTitleColor(UIColor.black, for: .normal)
        thirdButton.setTitle(parkButtonNumber.thrid, for: .normal)
        thirdButton.setTitleColor(UIColor.black, for: .normal)
        fourthButton.setTitle(parkButtonNumber.fourth, for: .normal)
        fourthButton.setTitleColor(UIColor.black, for: .normal)
        fifthButton.setTitle(parkButtonNumber.fifth, for: .normal)
        fifthButton.setTitleColor(UIColor.black, for: .normal)
        sixthButton.setTitle(parkButtonNumber.sixth, for: .normal)
        sixthButton.setTitleColor(UIColor.black, for: .normal)
        seventhButton.setTitle(parkButtonNumber.seventh, for: .normal)
        seventhButton.setTitleColor(UIColor.black, for: .normal)
        eighthButton.setTitle(parkButtonNumber.eight, for: .normal)
        eighthButton.setTitleColor(UIColor.black, for: .normal)
        ninthButton.setTitle(parkButtonNumber.ninth, for: .normal)
        ninthButton.setTitleColor(UIColor.black, for: .normal)
        
        // Search Button Set up
        searchButton.setTitle("호텔 검색하기", for: .normal)
        searchButton.backgroundColor = UIColor.orange
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        
        // Popular Hotel Button Set up
        
        hotelPopularFisrtButton.setTitle("오사카", for: .normal)
        hotelPopularFisrtButton.setTitleColor(UIColor.black, for: .normal)
        hotelPopularFisrtButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        hotelPopularSecondButton.setTitle("도쿄", for: .normal)
        hotelPopularSecondButton.setTitleColor(UIColor.black, for: .normal)
        hotelPopularSecondButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        hotelPopularThirdButton.setTitle("라스베가스", for: .normal)
        hotelPopularThirdButton.setTitleColor(UIColor.black, for: .normal)
        hotelPopularThirdButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        hotelPopularFourthButton.setTitle("삿포로", for: .normal)
        hotelPopularFourthButton.setTitleColor(UIColor.black, for: .normal)
        hotelPopularFourthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        hotelPopularFifthButton.setTitle("로마", for: .normal)
        hotelPopularFifthButton.setTitleColor(UIColor.black, for: .normal)
        hotelPopularFifthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        hotelPopularSixthButton.setTitle("피렌체", for: .normal)
        hotelPopularSixthButton.setTitleColor(UIColor.black, for: .normal)
        hotelPopularSixthButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)

        // Collection View Xib
        self.hotelPopularCollectionView.register(UINib(nibName: "HotelPopularCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HotelPopularCell")
        
        // Collection View Delegate, Datasource
        hotelPopularCollectionView.delegate = self
        hotelPopularCollectionView.dataSource = self
        
        // Alamofire
        alamofire(country: country, city: city)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Notification AddObserver Location Data
        NotificationCenter.default.addObserver(self, selector: #selector(deliveryLocationData(noti:)), name: NSNotification.Name(rawValue: "locationData"), object: nil)
        
        // Notification AddObserver Person Data
        NotificationCenter.default.addObserver(self, selector: #selector(deliveryPersonData(noti:)), name: NSNotification.Name(rawValue: "personData"), object: nil)
    }
    
    // Location Label Change
    @objc func deliveryLocationData(noti: Notification) {
        guard let notiUserInfo = noti.userInfo else { return }
        guard let notiUserInfoValue = notiUserInfo["select"] else { return }
        guard let stringNotiUserInfoVale = notiUserInfoValue as? String else { return }
        hotelLocationLabel.text = stringNotiUserInfoVale
        
    }
    
    // Person Label Change
    @objc func deliveryPersonData(noti: Notification) {
        guard let notiUserInfo = noti.userInfo else { return }
        print(notiUserInfo)
        
        guard let notiUserInfoAdult = notiUserInfo["adult"] else { return }
        guard let notiUserInfoKid = notiUserInfo["kid"] else { return }
        guard let notiUserInfoRoom = notiUserInfo["room"] else { return }
        
        hotelPersonLabel.text = "성인\(notiUserInfoAdult), 어린이\(notiUserInfoKid) / 객실\(notiUserInfoRoom)"
        
    }
    
    
    @IBAction func didTapHotelButton(_ sender: UIButton) {
        print("did Tap Hotel Button")
        
        self.viewContainer.bringSubview(toFront: hotelButtonView)
        searchButtonValue = 0
        searchButton.setTitle("호텔 검색하기", for: .normal)
        searchButton.backgroundColor = UIColor.orange
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        mainImage.image = #imageLiteral(resourceName: "Hotel")
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.buttonUnderBar.frame = CGRect(x: 78, y: 117, width: self.buttonUnderBar.frame.width, height: self.buttonUnderBar.frame.height)
        }, completion: nil)
        
    }
    
    
    @IBAction func didTapParkButton(_ sender: UIButton) {
        print("did Tap Park Button")
        
        self.viewContainer.bringSubview(toFront: parkButtonView)
        searchButtonValue = 1
        searchButton.setTitle("지역 선택", for: .normal)
        searchButton.backgroundColor = UIColor.purple
        searchButton.setTitleColor(UIColor.white, for: .normal)
        searchButton.layer.cornerRadius = 5
        searchButton.layer.masksToBounds = true
        mainImage.image = #imageLiteral(resourceName: "Park")
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseIn, animations: {
            self.buttonUnderBar.frame = CGRect(x: 188, y: 117, width: self.buttonUnderBar.frame.width, height: self.buttonUnderBar.frame.height)
        }, completion: nil)
    }
    
    @IBAction func didTapHotelLocationButton(_ sender: UIButton) {
        print("did Tap Hotel Location Button")
    }
    
    @IBAction func didTapHotelCalenderButton(_ sender: UIButton) {
        print("did Tap Hotel Calender Button")
        
        let dateRangePickerViewController = CalendarDateRangePickerViewController(collectionViewLayout: UICollectionViewFlowLayout())
        dateRangePickerViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: dateRangePickerViewController)
        self.navigationController?.present(navigationController, animated: true, completion: nil)
        
    }
    
    @IBAction func didTapHotelPersonButton(_ sender: UIButton) {
        print("did Tap Hotel Person Button")
    }
    
    @IBAction func didTapFirstButton(_ sender: UIButton) {
        print("did Tap First Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)        
    }
    
    @IBAction func didTapSecondButton(_ sender: UIButton) {
        print("did Tap Second Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapThirdButton(_ sender: UIButton) {
        print("did Tap Third Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapFourthButton(_ sender: UIButton) {
        print("did Tap Fourth Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapFifthButton(_ sender: UIButton) {
        print("did Tap Fifth Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Spain/Barcelona/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapSixthButton(_ sender: UIButton) {
        print("did Tap Sixth Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapSeventhButton(_ sender: UIButton) {
        print("did Tap Seventh Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapEighthButton(_ sender: UIButton) {
        print("did Tap Eighth Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Spain/Madrid/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapNinthButton(_ sender: UIButton) {
        print("did Tap Ninth Button")
        
        let singletonData: SingletonUrlData = SingletonUrlData.data
        singletonData.url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/khotels/Japan/Osaka/"
        
        let storyBoard = UIStoryboard(name: "LodgingView", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ParkSelectViewController")
        
        present(viewController, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapBannerButton(_ sender: UIButton) {
        
        guard let url = URL(string: "https://join.booking.com/?aid=376440&lang=ko&utm_source=index_banner&utm_medium=frontend&utm_content=small&contact_details=&label=bdot-HhWTaX_r6btPip7sfrk7SQS267777897793:pl:ta:p1:p2:ac:ap1t1:neg:fi:tiaud-297601666475:kwd-324456682700:lp1009871:li:dec:dm") else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func didTapHotelPopularFirstButton(_ sender: UIButton) {
        print("did Tap Hotel Popular First Button")
        alamofire(country: "Japan", city: "Osaka")
    }
    
    @IBAction func didTapHotelPopularSecondButton(_ sender: UIButton) {
        print("did Tap Hotel Popular Second Button")
        alamofire(country: "Japan", city: "Tokyo")
    }
    
    @IBAction func didTapHotelPopularThirdButton(_ sender: UIButton) {
        print("did Tap Hotel Popular Third Button")
        alamofire(country: "United+States+of+America", city: "Las+Vegas")
    }
    
    @IBAction func didTapHotelPopularFourthButton(_ sender: UIButton) {
        print("did Tap Hotel Popular Fourth Button")
        alamofire(country: "Japan", city: "Sapporo")
    }
    
    
    @IBAction func didTapHotelPopularFifthButton(_ sender: UIButton) {
        print("did Tap Hotel Popular Fifth Button")
        alamofire(country: "Italy", city: "Roma")
    }
    
    @IBAction func didTapHotelPopularSixthButton(_ sender: UIButton) {
        print("did Tap Hotel Popular Sixth Button")
        alamofire(country: "Italy", city: "Firenze")
    }
    
    
    
    
    
    
    
    
    @IBAction func didTapSearchButton(_ sender: UIButton) {
        print("did Tap Search Button")
        
        if searchButtonValue == 0 {
            
            guard let url = URL(string: "https://www.booking.com") else { return }
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
            
        } else { return }
    }
    
    deinit {
        print("Deinit")
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func alamofire(country: String, city: String) {
        
        let url = "http://myrealtrip-project.ap-northeast-2.elasticbeanstalk.com/api/accommodations/\(country)/\(city)/"
        Alamofire.request(url, method: .get).validate().responseData { (response) in
            switch response.result {
                
            case .success(let value):
                do {
                    let decode = try self.decoder.decode([HotelPopular].self, from: value)
                    print(decode)
                    self.hotelPopularArr = decode
                    print(self.hotelPopularArr.count)
                    self.hotelPopularCollectionView.reloadData()
                } catch {
                    print("Error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension LodgingViewController: CalendarDateRangePickerViewControllerDelegate {
    func didTapCancel() {
        dismiss(animated: true)
    }
    
    func didTapDoneWithDateRange(startDate: Date!, endDate: Date!) {
        dismiss(animated: true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, M, d, yyyy"
        hotelCalenderLabel.text = dateFormatter.string(from: startDate) + " - " + dateFormatter.string(from: endDate)
    }
    
    func didPickDateRange(startDate: Date!, endDate: Date!) {
        
        
    }
}

extension LodgingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelPopularArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: HotelPopularCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelPopularCell", for: indexPath) as! HotelPopularCollectionViewCell
        
        let url = URL(string: hotelPopularArr[indexPath.row].thumbnail)
        cell.hotelPopularImage.kf.setImage(with: url)
        cell.hotelPopularName.text = hotelPopularArr[indexPath.row].hotelName
        cell.hotelPopularPrice.text = hotelPopularArr[indexPath.row].price
        cell.hotelPopularGrade.text = hotelPopularArr[indexPath.row].grade
        
        return cell
    }
    
    
}
