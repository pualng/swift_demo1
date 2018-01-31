//
//  RecordTableViewCell.swift
//  demo2
//
//  Created by pojung wu on 2018/1/30.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var labTradeDate: UILabel!
    
    @IBOutlet weak var labAmount: UILabel!
   

    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
