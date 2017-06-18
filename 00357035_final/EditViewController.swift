//
//  EditViewController.swift
//  00357035_final
//
//  Created by user_09 on 2017/6/14.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class EditViewController: UITableViewController {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cardNameField: UITextField!
    @IBOutlet weak var nickNameField: UITextField!
    @IBOutlet weak var idolCell: UITableViewCell!
    @IBOutlet weak var done: UIBarButtonItem!

    var realName = ""
    var nickName = ""
    var indexPath = IndexPath()
    var propertyColor = UIColor()
    var tabParent = likeTabBarController()
    var frontPage = likeDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        done.target = self
        done.action = #selector(saveChanged)
        self.navigationItem.backBarButtonItem?.title = "Cancel"
        
        cardNameField.text = realName
        nickNameField.text = nickName
        icon.image = UIImage(named: realName + "+(ICON).png")
        idolCell.backgroundColor = propertyColor
        
        nickNameField.keyboardType = .default
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveChanged(sender: UIButton){
        var likeList = [[String:String]]()
        let newNickName = nickNameField.text
        
        if nickNameField.text?.characters.count == 0 {
            let controller = UIAlertController(title: "警告", message: "愛称を入れてください", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "確定", style: UIAlertActionStyle.default, handler: { (action) in})
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
            
            return
        }
        if newNickName != nickName {
            let fileManager = FileManager.default
            let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
            let docUrl = docUrls.first
            let url = docUrl?.appendingPathComponent("likeList.txt")
            
            do{
                let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
                for line in content.components(separatedBy: "\n"){
                    if(line.contains("\t")){
                        let s = line.components(separatedBy: "\t")
                        likeList.append(["nickName":s[0],"realName":s[1].decomposedStringWithCanonicalMapping,"type":s[2]])
                    }
                }
                print("read done")
                
                let dic = likeList[indexPath.row]
                let typeString = dic["type"]!
                likeList[indexPath.row] = ["nickName":newNickName!,"realName":realName,"type":typeString]
                
                var s = ""
                for dic in likeList{
                    s += dic["nickName"]! + "\t"
                    s += dic["realName"]! + "\t"
                    s += dic["type"]! + "\n"
                }
                
                do{
                    try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
                    print("write done")
                }catch{
                    return
                }
            }catch{
                return
            }
            tabParent.title = newNickName
            frontPage.nickName = newNickName!
            
        }
        self.navigationController?.popViewController(animated: true)
    }
    
}
