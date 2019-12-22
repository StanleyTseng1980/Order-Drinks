//
//  DrinksMenuViewController.swift
//  Order Drinks
//
//  Created by Stanley Tseng on 2019/12/21.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//
//  主程式碼參考自Julia學姐，感謝！

import UIKit

class DrinksMenuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // 預計當傳回點的ViewController，自己Key這段內容
    // 要回傳的ViewController點選button點Storyboard的Exit(上面三個的最右邊）
    @IBAction func OrderDrinksTableViewController(segue:
    UIStoryboardSegue) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
