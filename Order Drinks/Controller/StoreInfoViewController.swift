//
//  StoreInfoViewController.swift
//  Order Drinks
//
//  Created by Stanley Tseng on 2019/12/22.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData

class StoreInfoViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var StoreMKView: MKMapView!
    
    var myLocationManager :CLLocationManager!
    var myMapView :MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showDrinksStorePoint()
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        
        // 設置委任對象
        myLocationManager.delegate = self
        
        // 距離篩選器 用來設置移動多遠距離才觸發委任方法更新位置
        myLocationManager.distanceFilter =
        kCLLocationAccuracyNearestTenMeters
        
        // 取得自身定位位置的精確度
        myLocationManager.desiredAccuracy =
        kCLLocationAccuracyBest
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
            
        }
            // 使用者已經拒絕定位自身位置權限
        else if CLLocationManager.authorizationStatus() == .denied {
            // 提示可至[設定]中開啟權限
            let alertController = UIAlertController(
                title: "定位權限已關閉",
                message:
                "如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
            alertController.addAction(okAction)
            self.present(alertController,animated: true, completion: nil)
        }
            // 使用者已經同意定位自身位置權限
        else if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // 停止定位自身位置
        myLocationManager.stopUpdatingLocation()
    }
    
    func showDrinksStorePoint(){
        
        //可不可熟成紅茶的座標位置
        let location = CLLocation(latitude: 25.051138, longitude: 121.534933)
        //回傳 MKCoordinateRegion 結構的參數，這個參數決定了螢幕要顯示區域的大小。
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 300, longitudinalMeters: 300)
        StoreMKView.setRegion(region, animated: true)
        let annotation = MyAnnotation(coordingnate: location.coordinate)
        annotation.title = "可不可熟成紅茶"
        annotation.subtitle = "台北伊通店"
        StoreMKView.addAnnotation(annotation)
    }
    
    func locationManager(_ manager: CLLocationManager,didUpdateLocations locations: [CLLocation]) {
        
        // 印出目前所在位置座標
        let currentLocation :CLLocation = locations[0] as CLLocation
        print("\(currentLocation.coordinate.latitude)")
        print(", \(currentLocation.coordinate.longitude)")
        let showLocationannotation = MyAnnotation(coordingnate: currentLocation.coordinate)
        showLocationannotation.title = "現在位置"
        StoreMKView.addAnnotation(showLocationannotation)
    }
    
    @IBAction func callStoreButton(_ sender: Any) {
        let controller = UIAlertController(title: "可不可熟成紅茶-台北伊通店", message: "確定要打電話嗎？", preferredStyle: .actionSheet)
        let phoneNumber = "0225175510"
        let phoneAction = UIAlertAction(title: "打電話給\(phoneNumber)" , style: .default){(_) in
            if let url = URL(string: "tel:\(phoneNumber)"){
                if UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url,options: [:], completionHandler: nil)
                }else{
                    print("無法開啟URL")
                }
            }
            print("撥出成功")
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        controller.addAction(phoneAction)
        controller.addAction(cancelAction)
        present(controller,animated: true ,completion: nil)
        
    }
}
