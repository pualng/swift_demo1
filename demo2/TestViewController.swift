//
//  TestViewController.swift
//  demo2
//
//  Created by pojung wu on 2018/1/30.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
   // var dbHelper = DBHelper()
    var dbHelper : DBHelper = DBHelper()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnTest(_ sender: Any) {
        print("test!!!")
        
        dbHelper = DBHelper.init()  //這行多餘的
        
    }
    
    @IBAction func btnInsert(_ sender: Any) {
        let r = Record()
        r.amount = 200
        r.trade_date = "20180101"
        r.description = " 測試"
        r.trade_type = 0
        dbHelper.insert(record: r)
    }
    
    
    @IBAction func btnQuery(_ sender: Any) {
        let arr : [Record] = dbHelper.findAll()
        //print(arr.count)  //show count for check
        
        //full scan data by for loop
        for i  in 1...arr.count-1{
            print(arr[i].id);
            print(arr[i].description);
        }
    }
    
    
    @IBOutlet weak var btnQuery: UIButton!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
