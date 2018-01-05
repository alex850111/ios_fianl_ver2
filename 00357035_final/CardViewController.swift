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

    override func viewDidAppear(_ animated: Bool) {
        //setObjectPosition()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setObjectPosition(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        var bottomHeight:CGFloat = 0
        
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436{
            bottomHeight = self.view.safeAreaInsets.bottom
        }else{
            bottomHeight = (self.tabBarController?.tabBar.frame.size.height) ?? 0
        }
        
        cardView.frame.size.height = cardView.frame.size.height * screenWidth / cardView.frame.size.width
        cardView.frame.size.width = screenWidth
        
        cardView.frame.origin.x = 0
        cardView.frame.origin.y = screenHeight - bottomHeight - cardView.frame.size.height
    }
    
}
