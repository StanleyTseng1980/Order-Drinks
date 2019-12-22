//
//  TeaData.swift
//  Order Drinks
//
//  Created by Stanley Tseng on 2019/12/16.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//

import Foundation

// 讀取可不可熟成.txt用
struct DrinksList {
    var name: String
    var price: Int
}

// 讀取訂單內容用
struct TeaChoicesData {
    
    var name: String
    var drinks: String
    var size: String
    var sugar: SugarLevel
    var ice: IceLevel
    var tapioca:String
    var message: String
    var price: String
    
    init() {
            name = ""
            drinks = ""
            size = ""
            sugar = .regular
            ice = .regular
            tapioca = ""
            message = ""
            price = ""
    }
}

// 設定甜度等級
enum SugarLevel:String{
    case regular = "正常", lessSuger = "少糖", halfSuger = "半糖", quarterSuger = "微糖", sugerFree = "無糖"
}

// 設定冰度等級
enum IceLevel:String{
    case regular = "正常", moreIce = "少冰", easyIce = "微冰", iceFree = "去冰", completelyiceFree = "全去", hot = "熱飲"
}

// 顯示cell資料、上傳及下載sheetDB及下載資料用的
struct DrinksInformation : Codable{
    var name: String
    var drinks: String
    var size: String
    var sugar: String
    var ice: String
    var tapioca: String
    var message: String
    var price: String
    
    init?(json: [String : Any]) {
        guard let name = json["name"] as? String,
            let drinks = json["drinks"] as? String,
            let size = json["size"] as? String,
            let sugar = json["sugar"] as? String,
            let ice = json["ice"] as? String,
            let tapioca = json["tapioca"] as? String,
            let message = json["message"] as? String,
            let price = json["price"] as? String
                
            else {
                return nil
            }
            self.name = name
            self.drinks = drinks
            self.size = size
            self.sugar = sugar
            self.ice = ice
            self.tapioca = tapioca
            self.message = message
            self.price = price
    }
}

// 刪除及修改sheetDB資料用
struct Order:Encodable {
    var drinksdata:DrinksInformation
}
