//
//  likeDetailViewController.swift
//  00357035_final
//
//  Created by mari on 2017/6/11.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class likeDetailViewController: UIViewController {
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var nickNameEdit: UIBarButtonItem!
    @IBOutlet weak var propertyMark: UIImageView!
    @IBOutlet weak var petitView: UIImageView!
    

    var realName = ""
    var nickName = ""
    var tabParent = likeTabBarController()
    var likeIndexPath = IndexPath()
    var PropertyColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabParent = self.tabBarController as! likeTabBarController
        
        tabParent.navigationItem.rightBarButtonItem = nickNameEdit
        tabParent.navigationItem.backBarButtonItem?.title = "back"
        
        realName = tabParent.realName
        nickName = tabParent.nickName
        PropertyColor = tabParent.PropertyColor
        likeIndexPath = tabParent.likeIndexPath
        
        self.view.backgroundColor = PropertyColor
        propertyMark.image = UIImage(named : "mark_" + tabParent.Property)
        petitView.image = UIImage(named : (realName + "+(ぷち)").decomposedStringWithCanonicalMapping)
        
        if let asset = NSDataAsset(name : tabParent.realName), let contents = String(data:asset.data, encoding: String.Encoding.utf8){
            textArea.text = contents
        }else{
            textArea.text = "data not found"
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //setObjectPosition()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! EditViewController
        next.realName = realName
        next.nickName = nickName
        next.propertyColor = PropertyColor
        next.tabParent = tabParent
        next.indexPath = likeIndexPath
        next.frontPage = self
    }
    
    func setObjectPosition(){
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        var bottomHeight:CGFloat = 0
        
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436{
            bottomHeight += self.view.safeAreaInsets.bottom
        } else {
            bottomHeight = ((self.tabBarController?.tabBar.frame.size.height) ?? 0)
        }
        
        textArea.frame.origin.y = navigationBarHeight! + statusBarHeight
        textArea.frame.size.width = screenWidth
        textArea.frame.size.height = screenHeight
        
        propertyMark.frame.size.width = screenWidth - 30
        propertyMark.frame.size.height = propertyMark.frame.size.width
        propertyMark.frame.origin.x = 15
        propertyMark.frame.origin.y = ((navigationBarHeight ?? 0) + statusBarHeight + screenHeight - bottomHeight - propertyMark.frame.size.height) * 0.5
        
        petitView.frame.origin.x = screenWidth - petitView.frame.size.width + 15
        petitView.frame.origin.y = screenHeight - bottomHeight - petitView.frame.size.height - 15
    }
    
    
}
