//
//  CardViewController.swift
//  00357035_final
//
//  Created by mari on 2017/5/30.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    @IBOutlet weak var cardView: UIImageView!
    @IBOutlet var cardViewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let parent =  self.tabBarController as! cardTabBarController
        
        self.view.backgroundColor = parent.propertyColor
        cardView.image = UIImage(named : (parent.cardName + parent.idolName + "+(立ち絵)").decomposedStringWithCanonicalMapping)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
