//
//  DrinksListViewController.swift
//  Order Drinks
//
//  Created by Stanley Tseng on 2019/12/17.
//  Copyright © 2019 StanleyAppWorld. All rights reserved.
//
//  主程式碼參考自Julia學姐，感謝！

import UIKit

class DrinksListViewController: UIViewController, UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet var drinksListTableView: UITableView!
    @IBOutlet var numberOfDrinksLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var loadingActivityIndicator: UIActivityIndicatorView!
    
    var ListArray = [DrinksInformation]()
    
    // 訂單總杯數統計
    func updateOrdersUI(){
        numberOfDrinksLabel.text = "\(ListArray.count)"
    }
    
    // 訂單總金額統計
    func updatePriceUI() {
        var price = 0
        
        for i in 0 ..< ListArray.count {
            if let money = Int(ListArray[i].price){
                price += money
            }
        }
        totalPriceLabel.text = "\(price)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startLoadingList()
        drinksListTableView.delegate = self
        drinksListTableView.dataSource = self
        
        // Do any additional setup after loading the view.
    }
    
    // 畫面載入完成後清空原本array裡的資料，重新載入修改後的資料
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ListArray.removeAll()
        getOrderList()
    }
    
    // 開始載入動畫
    func startLoadingList(){
        loadingActivityIndicator.startAnimating()
    }
    
    // 停止載入動畫
    func stopLoadingList(){
        loadingActivityIndicator.stopAnimating()
        loadingActivityIndicator.hidesWhenStopped = true   // 當停止動畫後隱藏
    }
    
    // 得到要顯示的Cell，設定Cell的內容
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let information = ListArray[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "orderformcell", for: indexPath) as? DrinksTableViewCell
            else {
                return UITableViewCell()
        }
        cell.cellinformation = information
        cell.updateUI(id: indexPath.row)
        return cell
    }
    
    // 刪除cell資料
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let drinks = ListArray[indexPath.row]
        deleteOrderList(ListArray: drinks) // 呼叫刪除sheetDB裡資料的function
        ListArray.remove(at: indexPath.row) // 移除陣列裡的資料
        tableView.deleteRows(at: [indexPath], with: .automatic) // 刪除這個row
        tableView.reloadData() // 重新載入tableView
        updatePriceUI() // 更新總金額
        updateOrdersUI() // 更新總杯數
    }

    // 用didSelectRowAt indexPath選到Row去修改cell資料
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showedit", sender: indexPath)
    }
    
    // 取得sheetDB訂單資料
    func getOrderList() {
        let urlStr = "https://sheetdb.io/api/v1/1g3esvnlnt4b4".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        // 將網址轉換成URL編碼（Percent-Encoding）
        let url = URL(string: urlStr!) // 將字串轉換成url
        
        // 背景抓取茶飲訂單資料
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let data = data, let content = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{
                // 因為資料的Json的格式為陣列（Array）包物件（Object），所以[[String: Any]]
                
                for order in content {
                    if let data = DrinksInformation(json: order){
                        self.ListArray.append(data)
                    }
                }
                
                // 更新TableView，UI的更新必須在Main thread
                DispatchQueue.main.async {
                    self.stopLoadingList() // 停止Loading動畫並且關閉圖示
                    self.drinksListTableView.reloadData() // 更新訂購表
                    self.updateOrdersUI() // 更新訂購數量
                    self.updatePriceUI() // 更新總價
                }
            }
        }
        task.resume() // 開始在背景下載資料
    }
    
    // 刪除sheetDB訂單資料
    func deleteOrderList(ListArray:DrinksInformation) {
        if let urlStr = "https://sheetdb.io/api/v1/1g3esvnlnt4b4/name/\(ListArray.name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlStr){
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "DELETE"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let List = Order(drinksdata: ListArray)
            let jsonEncoder = JSONEncoder()
            if let data = try? jsonEncoder.encode(List){
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data){(retData,response, error)in
                    let decoder = JSONDecoder()
                    if let retData = retData , let dic = try? decoder.decode([String:Int].self, from:retData),dic["deleted"] == 1{
                        print("Successfully deleted")
                    }else{
                        print("Failed to delete")
                    }
                }
                task.resume()
            }else{
                print("Delete")
            }
        }
    }
    
    // 修改cell資料，將茶飲訂單cell裡的資料存到下一頁的訂購茶飲頁面
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if let controller = segue.destination as? OrderDrinksTableViewController, let row = drinksListTableView.indexPathForSelectedRow?.row  {
            let editOrderData = ListArray[row]
            controller.editOrderData = editOrderData
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
