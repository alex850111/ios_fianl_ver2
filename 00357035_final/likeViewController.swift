//
//  likeViewController.swift
//  00357035_final
//
//  Created by user_05 on 2017/5/24.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class likeViewController: UIViewController {
    @IBOutlet weak var cardView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parent = self.tabBarController as! likeTabBarController
        self.view.backgroundColor = parent.PropertyColor
        
        cardView.image = UIImage(named : (parent.realName + "+(立ち絵)").decomposedStringWithCanonicalMapping)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

