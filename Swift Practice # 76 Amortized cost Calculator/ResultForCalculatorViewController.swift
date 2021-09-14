//
//  ResultForCalculatorViewController.swift
//  Swift Practice # 76 Amortized cost Calculator
//
//  Created by Dogpa's MBAir M1 on 2021/9/14.
//

import UIKit

class ResultForCalculatorViewController: UIViewController {
    
    //自定義變數
    var itemNameFromInputPage: String!      //上一頁的物品名稱
    var priceFromInputPage: Int!            //上一頁的金額
    var purchaseDateFromInput: Date!        //上一頁選擇的購買日期
    var endOfUseDateFromIntput: Date!       //上一頁選擇的結束使用日期
    var purchaseDateShowOnLabel: String!    //日期格式為"yyyy-MM-dd"的購買日期
    var endUseDateShowOnLabel: String!      //日期格式為"yyyy-MM-dd"的結束使用日期
    var dateForNowString: String!           //日期格式為"yyyy-MM-dd"的今天
    
    
    
    @IBOutlet weak var showPurchaseDateLabel: UILabel!      //購買日期Label
    @IBOutlet weak var showEndToUseDateLabel: UILabel!      //結束使用日期Label
    @IBOutlet weak var showUseDaysLabel: UILabel!           //使用天數Label
    @IBOutlet weak var showAmortizedCostLabel: UILabel!     //攤提成本Label
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if endUseDateShowOnLabel != nil , endUseDateShowOnLabel != nil, dateForNowString != nil{
            showPurchaseDateLabel.text = purchaseDateShowOnLabel!   //購買日期的顯示內容
            
            //若結束日為今天，表示物品仍在使用
            if endUseDateShowOnLabel! == dateForNowString! {
                showEndToUseDateLabel.text = "仍在使用"
            //若不是則顯示結束指定的使用日期
            }else{
                showEndToUseDateLabel.text = endUseDateShowOnLabel!
            }
            
            //透過Calendar.current.dateComponents取得兩個日期的差異內容
            let totalUseDaysdateComponents = Calendar.current.dateComponents([.day], from: purchaseDateFromInput, to: endOfUseDateFromIntput)
            
            //取得差異內容的「天數」
            let totalUseDays = totalUseDaysdateComponents.day!
            
            //showUseDaysLabel顯示上面取得的天數
            showUseDaysLabel.text = "\(String(totalUseDays)) 天"
            
            //攤提成本為購買金額除使用天數
            let AmortizedPrice = Float(priceFromInputPage) / Float(totalUseDays)
            
            //取得數字格式，要有三位數逗點及小數點一位
            let floatStringformatter = NumberFormatter()
            floatStringformatter.numberStyle = .decimal
            floatStringformatter.maximumFractionDigits = 1
            
            //showAmortizedCostLabel顯示內容為剛剛取得的攤題成本透過上面指定的顯示格式顯示
            showAmortizedCostLabel.text = "\(floatStringformatter.string(from: NSNumber(value: AmortizedPrice))!) 元"
        }
        
    }
    
    //返回前頁
    @IBAction func goToIntputPage(_ sender: Any) {
        
        //跳轉到第一頁
        self.tabBarController?.selectedIndex = 0
        
        //本頁四個Laebl顯示空字串
        showPurchaseDateLabel.text = ""
        showEndToUseDateLabel.text = ""
        showUseDaysLabel.text = ""
        showAmortizedCostLabel.text = ""
        
    }
    

    

}
