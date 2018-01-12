//
//  mainViewController.swift
//  00357035_final
//  Created by user_05 on 2017/5/24.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class mainViewController: UITableViewController {
    var idols = [[String:String]]()
    var displayList = [[String:String]]()
    var isDisplay = [String:Bool]()
    var typeColor = [String:UIColor]()
    @IBOutlet weak var switchPanel: UIView!
    
    @IBOutlet weak var cuteSwitch: UISwitch!
    @IBOutlet weak var coolSwitch: UISwitch!
    @IBOutlet weak var passionSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let asset = NSDataAsset(name : "IdolNameList"), let contents = String(data:asset.data, encoding: String.Encoding.utf8){
            for line in contents.components(separatedBy: "\n"){
                if line.contains("\t"){
                    var s = line.components(separatedBy: "\t")
                    s[0] = s[0].decomposedStringWithCanonicalMapping
                    idols.append(["name":s[0],"type":s[1]])
                    displayList.append(["name":s[0],"type":s[1]])
                }
            }
        }
        
        typeColor = ["cute":UIColor(red: CGFloat(255.0/255.0), green: CGFloat(188.0/255.0), blue: CGFloat(228.0/255.0), alpha: CGFloat(1.0)),
                     "cool":UIColor(red: CGFloat(207.0/255.0), green: CGFloat(241.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(1.0)),
                     "passion":UIColor(red: CGFloat(255.0/255.0), green: CGFloat(245.0/255.0), blue: CGFloat(202.0/255.0), alpha: CGFloat(1.0))]
        
        isDisplay = ["cute" : true, "cool" : true, "passion" : true]
        
        cuteSwitch.addTarget(self, action: #selector(updateDisplaySelection), for: UIControlEvents.allEvents)
        coolSwitch.addTarget(self, action: #selector(updateDisplaySelection), for: UIControlEvents.valueChanged)
        passionSwitch.addTarget(self, action: #selector(updateDisplaySelection), for: UIControlEvents.valueChanged)
        
        checkIsLikeListExist()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView,numberOfRowsInSection section: Int) ->Int {
        return displayList.count
    
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) ->IdolTableCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "idolCell", for: indexPath) as! IdolTableCell
        
            let dic = displayList[indexPath.row]
            cell.Name.text = dic["name"]
            cell.Icon.image = UIImage(named: (dic["name"]! + "_icon"))
            var colorName:String
            colorName = dic["type"]!
            cell.backgroundColor = typeColor[colorName]
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
        let indexPath = tableView.indexPathForSelectedRow
        let controller = segue.destination as! cardOfIdolTableViewController
        let dic = displayList[indexPath!.row]
        controller.idolName = dic["name"]!
        controller.cellColor = typeColor[dic["type"]!]!
        controller.property = dic["type"]!
    }
    
    func checkIsLikeListExist(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("likeList.txt")
        
        do{
            _ = try String(contentsOf: url!, encoding: String.Encoding.utf8)
        }
        catch{
            let s = ""
            do{
                try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
            }catch{
            }
        }
    }
    
    func updateDisplaySelection(){
        isDisplay["cute"] = cuteSwitch.isOn
        isDisplay["cool"] = coolSwitch.isOn
        isDisplay["passion"] = passionSwitch.isOn
        setDisplayList();
    }
    
    func setDisplayList(){
        displayList.removeAll()
        for dic in idols{
            if isDisplay[dic["type"]!]!{
                displayList.append(dic)
            }
        }
        self.tableView.reloadData()
    }
    
}

