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
    
}
