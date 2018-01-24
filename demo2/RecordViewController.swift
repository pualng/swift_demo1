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


    //Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()  //呼叫  UIViewController.viewDidLoad  (父類別的Functino)

        // Do any additional setup after loading the view.
        
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
        txtMoney.text = "1000000"
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
