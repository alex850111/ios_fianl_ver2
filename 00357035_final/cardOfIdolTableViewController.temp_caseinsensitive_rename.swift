//
//  CardOfIdolTableViewController.swift
//  00357035_final
//
//  Created by mari on 2017/5/27.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class cardOfIdolTableViewController: UITableViewController {
    var idolName = ""
    var property = ""
    var idolCard = [String]()
    var cellColor = UIColor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let asset = NSDataAsset(name : idolName), let contents = String(data:asset.data, encoding: String.Encoding.utf8){
            for line in contents.components(separatedBy: "\n"){
                if !line.isEmpty{
                    idolCard.append(line.decomposedStringWithCanonicalMapping)
                }
            }
            print(idolCard)
        }
        title = idolName
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idolCard.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> CardTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "idolCell", for: indexPath) as! CardTableViewCell
        
        cell.cardName.text = idolCard[indexPath.row]
        cell.backgroundColor = cellColor
        cell.cardIcon.image = UIImage(named : (idolCard[indexPath.row] + idolName + "+(ICON).png"))
        print(idolCard[indexPath.row] + idolName + "+(ICON)")
        
        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabCon = segue.destination as! cardTabBarController
        let indexPath = tableView.indexPathForSelectedRow
        tabCon.propertyColor = cellColor
        tabCon.cardName = idolCard[(indexPath?.row)!]
        tabCon.idolName = idolName
        tabCon.property = property
        tabCon.title = tabCon.cardName
    }
    

}
