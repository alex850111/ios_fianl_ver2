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
    
    override func viewDidAppear(_ animated: Bool) {
        //setObjectPosition()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setObjectPosition(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        var bottomHeight:CGFloat = 0
        
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436{
            bottomHeight = self.view.safeAreaInsets.bottom
        } else {
            bottomHeight = (self.tabBarController?.tabBar.frame.size.height) ?? 0
        }
        
        cardView.frame.size.height = cardView.frame.size.height * screenWidth / cardView.frame.size.width
        cardView.frame.size.width = screenWidth
        
        cardView.frame.origin.x = 0
        cardView.frame.origin.y = screenHeight - bottomHeight - cardView.frame.size.height
    }
    
}

