//
//  DBHelper.swift
//  demo2
//
//  Created by pojung wu on 2018/1/30.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import Foundation
import SQLite


class DBHelper{
    //變數（資料）
    
    //DB連線變數，所有的操作都透過connection
    var  db:Connection!
    
    //DB的路徑
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    
    
    //提供SQLTable 變數
    
    //DB設定，Table , Col. Name etc.
    let records = Table("records")
    //下列可以參考 Record Class
    let id = Expression<Int64> ("id")
    let trade_type = Expression<Int64>("trade_type")
    let trade_date = Expression<String>("trade_date")
    let amount = Expression<Double>("amount")
    let description = Expression<String?>("description")
    let photo_path = Expression<String?>("photo_path") //可null
    
    //函數
    // - 建構式 construction
    init(){
        do{
            print("DB 所在資料夾 : \(path)")
            
            db = try Connection("\(path)/mydb.sqlite")
            
            createTable()
            
        }catch{
            print("Error : \(error)")
        }
    }

    // - 其他：  public function or Support Function
    //建立資料表
    func createTable(){
        do{
            //組合SQL語法
            let cmd  = records.create(ifNotExists:true){
                t in
                t.column(id, primaryKey: true)
                t.column(trade_type)
                t.column(trade_date)
                t.column(amount)
                t.column(description)
                t.column(photo_path)
            }
            //debug
            print(cmd.asSQL())
            //執行命令
            try db!.run(cmd)
            
        }catch{
            print("Error : \(error)")
        }
    }
    
    //新增資料
    func insert(record:Record) ->Int64{
        do{
            //組合SQL語法
            let cmd = records.insert(
                trade_type<-record.trade_type,
                trade_date<-record.trade_date,
                amount<-record.amount,
                description<-record.description,
                photo_path<-record.photo_path)
            //debug
            print(cmd.asSQL())
            //執行命令
            return try db!.run(cmd)
            
        }catch{
            print("Error : \(error)")
            return -1
        }
    }
    
    //查詢所有資料
    func findAll() -> [Record]{
        var result = [Record]()
        do{
            let all = Array(try db!.prepare(records))
            for item in all{
                result.append(
                    Record(id: item[id],
                           trade_type: item[trade_type],
                           trade_date :item[trade_date],
                           amount:item[amount],
                           description:item[description]!,
                           photo_path:item[photo_path]!
                ))
            }
        }catch{
            print("Error : \(error)")
        }
        return result
    }
    
}
