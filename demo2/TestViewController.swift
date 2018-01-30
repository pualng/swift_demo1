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
      //for delete test
        let data = dbHelper.findAll()
        let last = data[data.count-1]  //last one
        //ex: 0 1 2 3 4  -> count =5 , last index = 4 , lastindex = count -1
        
        last.amount = 999
        dbHelper.update(record: last)
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
        for i  in 0...arr.count-1{
            print(arr[i].id);
            print(arr[i].amount);
        }
    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
        
        //for delete test
        let data = dbHelper.findAll()
        let last = data[data.count-1]  //last one
        //ex: 0 1 2 3 4  -> count =5 , last index = 4 , lastindex = count -1
        dbHelper.delete(index: last.id)
        
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
