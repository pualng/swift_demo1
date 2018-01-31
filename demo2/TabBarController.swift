//
//  TabBarController.swift
//  demo2
//
//  Created by pojung wu on 2018/1/31.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit
import FontAwesome_swift

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //必須 import FontAwesome_swift
        var itemLabels = ["列表", "統計", "設定","測試"]
        // 代表fontAwesome的三種圖形
        var itemIcons = [FontAwesome.asterisk, FontAwesome.gift, FontAwesome.addressBook,FontAwesome.adjust]
        
        let tabItems = self.tabBar.items as [UITabBarItem]!
        
        for index in 0..<itemLabels.count {
            let currentItem = tabItems![index] as UITabBarItem
            
            currentItem.title = itemLabels[index]
            // 我現在要讓TbarBar[index]的圖片變成fonAwesome的asterisk, 文字顏色, size=(30,30)
            currentItem.image = UIImage.fontAwesomeIcon(name: itemIcons[index], textColor: UIColor.black, size: CGSize(width: 30, height: 30))
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
