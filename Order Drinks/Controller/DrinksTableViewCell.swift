//
//  DrinksTableViewCell.swift
//  Order Drinks
//
//  Created by Stanley Tseng on 2019/12/16.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//
//  主程式碼參考自Julia學姐，感謝！

import UIKit

class DrinksTableViewCell: UITableViewCell {
    
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var drinksLabel: UILabel!
    @IBOutlet var sizeLabel: UILabel!
    @IBOutlet var sugerLabel: UILabel!
    @IBOutlet var iceLabel: UILabel!
    @IBOutlet var tapiocaLabel:UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    
    var cellinformation: DrinksInformation!
    
    func updateUI(id: Int ) {
        numberLabel.text = "\(id + 1)"
        nameLabel.text = "我是：\(cellinformation.name)"
        drinksLabel.text = "茶飲：\(cellinformation.drinks)"
        sizeLabel.text = "容量：\(cellinformation.size)"
        sugerLabel.text = "甜度：\(cellinformation.sugar)"
        iceLabel.text = "冰度：\(cellinformation.ice)"
        tapiocaLabel.text = "珍珠：\(cellinformation.tapioca)"
        messageLabel.text = "備註：\(cellinformation.message)"
        priceLabel.text = "金額：\(cellinformation.price)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}

