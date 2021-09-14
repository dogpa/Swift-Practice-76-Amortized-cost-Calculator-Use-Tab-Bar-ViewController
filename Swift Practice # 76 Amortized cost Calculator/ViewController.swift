//
//  ViewController.swift
//  Swift Practice # 76 Amortized cost Calculator
//
//  Created by Dogpa's MBAir M1 on 2021/9/14.
//

import UIKit


class ViewController: UIViewController {
    
    //點選任意螢幕位置收鍵盤
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        }
        @objc func dismissKeyboard() {
        view.endEditing(true)
        }
    
    
    @IBOutlet weak var itemNameTextField: UITextField!      //輸入物品名稱的TextField
    @IBOutlet weak var priceOfItemTextField: UITextField!   //輸入金額的TextField
    @IBOutlet weak var purchaseDatePicker: UIDatePicker!    //選擇購買日期的DatePicker
    @IBOutlet weak var endUseDatePicker: UIDatePicker!      //選擇結束使用日期的DatePicker
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    //再次出現第一頁將兩個textField改為空字串
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        itemNameTextField.text = ""
        priceOfItemTextField.text = ""
    }
    
    //不同警告內容的自定義Function
    func alertWaringString (titleString: String, messageString: String, actionString: String) {
        let alertController = UIAlertController(title: titleString , message: messageString, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionString, style: .default)
                        alertController.addAction(okAction)
                        present(alertController, animated: true, completion: nil)
    }
    
    //按下按鈕需執行項目
    @IBAction func calculatorAmortizedCost(_ sender: Any) {
     
        let nameOfItem = String(itemNameTextField.text ?? "")       //指派nameOfItem取得itemNameTextField的值
        let priceOfItem = Int(priceOfItemTextField.text ?? "")      //指派priceOfItem取得priceOfItemTextField的值
        let purchaseDate = purchaseDatePicker.date                  //指派purchaseDate取得purchaseDatePicker所選日期
        let endToUseDate = endUseDatePicker.date                    //指派endToUseDate取得endUseDatePicker所選日期
        
        //日期顯示字串後續比較用以及下一頁顯示label值使用
        let dateFormatter = DateFormatter()                         //指派dateFormatter取得時間格式DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "zh-tw")     //dateFormatter時區為台灣
        dateFormatter.dateFormat = "yyyy-MM-dd"                     //dateFormatter日期顯示格式為"yyyy-MM-dd"
        let ifUseForPurchaseDate = dateFormatter.string(from: purchaseDate)     //將purchaseDate日期轉型為字串格式為yyyy-MM-dd後指派給ifUseForPurchaseDate
        let ifUseForEndToUseDate = dateFormatter.string(from: endToUseDate)     //將endToUseDate日期轉型為字串格式為yyyy-MM-dd後指派給ifUseForEndToUseDate
        let dateForNow = dateFormatter.string(from: Date())                     //將現在的日期轉型為字串格式為yyyy-MM-dd後指派給dateForNow
        
        //日期顯示字串後轉Int後續比較日期大小用
        let dateFormatterUseToCpmpare = DateFormatter()                     //指派dateFormatterUseToCpmpare取得時間格式DateFormatter()
        dateFormatterUseToCpmpare.locale = Locale.init(identifier: "zh-tw") //dateFormatterUseToCpmpare時區為台灣
        dateFormatterUseToCpmpare.dateFormat = "yyyyMMdd"                   //dateFormatterUseToCpmpare轉型日期格式為yyyyMMdd
        let intForPurchaseDate = Int(dateFormatterUseToCpmpare.string(from: purchaseDate))//將轉型為yyyyMMdd格式的日期轉型為Int後指派給intForPurchaseDate
        let intForEndToUseDate = Int(dateFormatterUseToCpmpare.string(from: endToUseDate))//將轉型為yyyyMMdd格式的日期轉型為Int後指派給intForEndToUseDate
        
        //列印測試
        //print(intForPurchaseDate!)
        //print(type(of: intForPurchaseDate!))
        //print(intForEndToUseDate!)
        
        

        
        //判斷各自的輸入值是否有無法計算的可能
        if nameOfItem == "" || priceOfItem == nil || priceOfItem == 0 || ifUseForPurchaseDate == ifUseForEndToUseDate || intForEndToUseDate! < intForPurchaseDate! {
            
            //品項及金額為輸入或輸入金額為0
            if nameOfItem == "" || priceOfItem == nil || priceOfItem == 0{
                alertWaringString(titleString: "品項與金額輸入有誤", messageString: "請返回原畫面再次確認", actionString: "了解")
            
            //兩個透過轉型後的字串的DatePicker若為同天
            }else if ifUseForPurchaseDate == ifUseForEndToUseDate {
                alertWaringString(titleString: "日期同天", messageString: "買來就丟？？", actionString: "返回修正")
            
            //結束使用比購買日期還要早發生
            }else if intForEndToUseDate! < intForPurchaseDate! {
                alertWaringString(titleString: "時光隧道", messageString: "使用結束時間比買的時間早", actionString: "返回調整")
            }
            
        //上述無法計算與未來時間狀況都沒有發生
        }else{
            //指派 resultVC轉型為第二頁ResultForCalculatorViewController
            if let resultVC = self.tabBarController?.viewControllers?[1] as? ResultForCalculatorViewController{
                //測試列印
                //print(type(of: purchaseDate))
                //print(type(of: ifUseForPurchaseDate))
                
                //將ResultForCalculatorViewController的變數指派為本頁的值
                resultVC.itemNameFromInputPage = nameOfItem
                resultVC.priceFromInputPage = priceOfItem
                resultVC.purchaseDateFromInput = purchaseDate
                resultVC.endOfUseDateFromIntput = endToUseDate
                resultVC.purchaseDateShowOnLabel = ifUseForPurchaseDate
                resultVC.endUseDateShowOnLabel = ifUseForEndToUseDate
                resultVC.dateForNowString = dateForNow
                
                self.tabBarController?.selectedIndex = 1  //跳轉到第二頁
                
            }
        }

    }

    
}

