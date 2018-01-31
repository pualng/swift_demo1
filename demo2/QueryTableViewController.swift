//
//  QueryTableViewController.swift
//  demo2
//
//  Created by pojung wu on 2018/1/24.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit

class QueryTableViewController: UITableViewController {
    //outlet
    @IBOutlet var tbvData: UITableView!
    //變數區
    var data : [Record] = []
    var dbHelper : DBHelper = DBHelper()
    
    var dateToSend : Record? = nil //提供給 傳遞資料用

    //【生命週期】 視窗建立的時呼叫（只有一次）
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //【生命週期】 畫面重載時呼叫 （ex:跳去A畫面在返回）
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //正式資料
        data = dbHelper.findAll()
        self.tbvData.reloadData()
    }
    //【生命週期】 記憶體釋放的時候 - 準備關閉
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! RecordTableViewCell

        cell.labTradeDate.text = "\(data[indexPath.row].trade_date)"

        cell.labAmount.text = "$ \(data[indexPath.row].amount)"


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        dateToSend = data[indexPath.row] //暫存
        //呼叫線路傳遞
        self.performSegue(withIdentifier: "gotodetail", sender: self)

    }

    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //取得目標型態
        let dest = segue.destination as! RecordViewController
   
        dest.source = dateToSend
        
    }
    

}
