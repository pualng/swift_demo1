//
//  Record.swift
//  sqlite_demo
//
//  Created by pojung wu on 2017/5/11.
//  Copyright © 2017年 pojung wu. All rights reserved.
//

import Foundation


class Record{
    var id : Int64=0
    var trade_type :Int64 = 0
    var trade_date :String = ""
    var amount :Double = 0.0
    var description  :String=""
    var photo_path  :String=""
    
    
    init(){
        
    }
    
    init(trade_type :Int64,trade_date :String,amount :Double){
        
        self.id = 0
        self.trade_type = trade_type
        self.trade_date = trade_date
        self.amount = amount
        self.description = ""
        self.photo_path = ""
    }
    
    
  init(id:Int64,trade_type :Int64,trade_date :String,amount :Double,description  :String,photo_path  :String){
        
        self.id=id
        self.trade_type = trade_type
        self.trade_date = trade_date
        self.amount = amount
        self.description = description
        self.photo_path = photo_path
    }
    
}

