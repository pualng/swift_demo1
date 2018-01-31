//
//  RecordViewController.swift
//  demo2
//
//  Created by pojung wu on 2018/1/24.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController ,UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
    
    //變數 -（Outlet)
    @IBOutlet weak var segType: UISegmentedControl!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtMoney: UITextField!
    @IBOutlet weak var txtDesc: UITextView!
    
    @IBOutlet weak var btnDel: UIButton!
    
    @IBOutlet weak var imgView: UIImageView!
    
    
    //變數
    var source : Record? = nil  // ？  c# nullable
    let dbh : DBHelper = DBHelper.init()  //取得協助方法
    let timeInterval = Int(NSDate().timeIntervalSince1970) //取得目前時間
    var fileName : String  = ""
    
    //時間戳

    //Lift Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if(source != nil){  //有人傳值進來，這是編輯模式
            txtDate.text = source!.trade_date
            txtMoney.text = "\(source!.amount)"
            txtDesc.text = source!.description
            segType.selectedSegmentIndex = Int(source!.trade_type)
            
            if(!source!.photo_path.isEmpty){  //表示有圖片，/抓出來show
                //產生path
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let filePath = documentsURL.appendingPathComponent("\(String(describing: source!.photo_path))").path
                
                //檢查path 是否存在
                if FileManager.default.fileExists(atPath: filePath) {
                    print("img:\(filePath)")
                    let img = UIImage(contentsOfFile: filePath)  //讀檔
                    imgView.image = img;
                }
                
            }
        }else{
            //新增模式
            btnDel.isHidden = true  //隱藏刪除按鈕
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
        //檢查變數
        
        if(txtMoney.text!.isEmpty){
            alert(Title: "系統提示",Message: "金額不得為空")
            return
        }
        if(txtDesc.text.isEmpty){
            alert(Title: "系統提示",Message: "說明不得為空")
            return
        }
        if(txtDate.text!.isEmpty){
            alert(Title: "系統提示",Message: "日期不得為空")
            return
        }
        
        //寫入資料庫
        if(source == nil){  //新增
            //整理資料
            let r = Record()
            r.amount = Double(txtMoney.text!)!
            r.trade_date = txtDate.text!
            r.description = txtDesc.text!
            r.trade_type = Int64(segType.selectedSegmentIndex)
            r.photo_path = fileName;
              //寫入DB
            _ = dbh.insert(record: r)  //改成 _下底線
        }else{  //編輯
            //更新資料
            source!.trade_date = txtDate.text!
            source!.amount = Double(txtMoney.text!)!
            source!.description = txtDesc.text!
            source!.trade_type = Int64(segType.selectedSegmentIndex)
            source!.photo_path = fileName;
            //寫入DB
            dbh.update(record: source!) //update
        }
        
    }
    
    func alert(Title:String, Message:String){
        let cancelAction = UIAlertAction(title: "確認", style: .default, handler: nil)
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: .alert)
            alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnDelClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "貼心提醒", message: "刪除後無法復原！請問是否刪除", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("確定刪除", comment: "Default action"), style: UIAlertActionStyle.destructive, handler: { _ in
            //刪除
            self.dbh.delete(index: self.source!.id)
        }))
        
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("取消", comment: "Default action"), style: .cancel, handler: { _ in
            //nothing todo
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func btnImage(_ sender: Any) {
        //開啟UIImagepicker
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.modalPresentationStyle = .popover
        imagePicker.delegate = self  //注意理解這行
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //關閉畫面
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        //將圖片取出
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        //設定oulet 物件的image
        imgView.image = chosenImage
        
        // 存檔
        do {
            //計算路徑 （絕對路徑)
            fileName = "img_"  + String(timeInterval) + ".png"
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentsURL.appendingPathComponent("\(fileName)") //documentsURL+fileName
            
            if let pngImageData = UIImagePNGRepresentation(chosenImage) {
                try pngImageData.write(to: fileURL, options: .atomic)
                print("存擋完成:\(fileURL)") //for debug
            }
        } catch {
        }
        
        //關閉畫面
        dismiss(animated: true, completion: nil)
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
