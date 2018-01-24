//
//  RecordViewController.swift
//  demo2
//
//  Created by pojung wu on 2018/1/24.
//  Copyright © 2018年 paul.ng. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {

    @IBOutlet weak var txtDate: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()  //呼叫  UIViewController.viewDidLoad  (父類別的Functino)

        // Do any additional setup after loading the view.
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
