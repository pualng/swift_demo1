//
//  RecordViewController.swift
//  demo2
//
//  Created by pojung wu on 2018/1/24.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    //變數 -（Outlet)
    @IBOutlet weak var segType: UISegmentedControl!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtMoney: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    //變數
    var source : Record? = nil

    //Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if(source != nil){  //有人傳值進來，這是編輯模式
            txtDate.text = source!.trade_date
            txtMoney.text = "\(source!.amount)"
            txtDesc.text = source!.description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 這一頁,的view,然後關閉編輯(YES)
        self.view.endEditing(true)
    }
    
    
    @IBAction func actDateEditing(_ sender: UITextField) {
        var dp  = UIDatePicker()
        //設定 DP
        dp.datePickerMode = UIDatePickerMode.date
        dp.locale = Locale(identifier: "zh-TW")
        //變更input view (輸入模式）
        sender.inputView = dp
        //新增觸法
        dp.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
    }
    
    @objc func handleDatePicker(sender : UIDatePicker){
        //txtDate.text = "\(sender.date)"
        //轉換格式
        var df =  DateFormatter()
        df.dateFormat = "yyyy/MM/dd"
         //逕行轉換
        let dates:String = df.string(from: sender.date)
         //設定
        txtDate.text = dates
    }
    
    //Action
    @IBAction func btnSave(_ sender: Any) {
        print("save...")
        //txtMoney.text = "1000000"
        //判斷是 新增 還是編輯？
        if(source == nil){  //新增
            
        }else{  //編輯
            
            let dbh : DBHelper = DBHelper.init()  //取得協助方法
            
            //更新資料
            source!.trade_date = txtDate.text!
            source!.amount = Double(txtMoney.text!)!
            source?.description = txtDesc.text!
            
            dbh.update(record: source!) //update
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
