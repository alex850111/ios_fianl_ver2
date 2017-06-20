//
//  likeTableViewController.swift
//  00357035_final
//
//  Created by mari on 2017/6/11.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class likeTableViewController: UITableViewController {
    
    let nickName = "nickName", realName = "realName", type = "type"
    var likeList = [[String:String]]()
    var typeColor = [String:UIColor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        
        self.navigationItem.rightBarButtonItem =
            self.editButtonItem
        
        typeColor = ["cute":UIColor(red: CGFloat(255.0/255.0), green: CGFloat(188.0/255.0), blue: CGFloat(228.0/255.0), alpha: CGFloat(1.0)),
                     "cool":UIColor(red: CGFloat(207.0/255.0), green: CGFloat(241.0/255.0), blue: CGFloat(255.0/255.0), alpha: CGFloat(1.0)),
                     "passion":UIColor(red: CGFloat(255.0/255.0), green: CGFloat(245.0/255.0), blue: CGFloat(202.0/255.0), alpha: CGFloat(1.0))]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return likeList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "likeCell", for: indexPath) as! LikeTableCell

        let dic = likeList[indexPath.row]
        cell.card_idolText.text = dic[nickName]
        cell.cardIcon.image = UIImage(named: dic[realName]! + "+(ICON).png")
        cell.backgroundColor = typeColor[dic[type]!]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let next = segue.destination as! likeTabBarController
        let indexPath = tableView.indexPathForSelectedRow
        let dic = likeList[(indexPath?.row)!]
        
        next.nickName = dic[nickName]!
        next.Property = dic[type]!
        next.realName = dic[realName]!
        next.PropertyColor = typeColor[dic[type]!]!
        next.likeIndexPath = indexPath!
        next.title = dic[nickName]!
    }
    
    func loadData(){
        let tempList = likeList
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("likeList.txt")
        
        do{
            likeList.removeAll()
            let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            for line in content.components(separatedBy: "\n"){
                if(line.contains("\t")){
                    let s = line.components(separatedBy: "\t")
                    print(line)
                    likeList.append([nickName:s[0],realName:s[1].decomposedStringWithCanonicalMapping,type:s[2]])
                }
            }
        }
        catch{
            let s = ""
            do{
                try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
                print("good")
            }
            catch{print("dead")}
            likeList = tempList
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            likeList.remove(at: indexPath.row)
            saveList()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    func saveList(){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("likeList.txt")
        
        do{
            var s = ""
            for dic in likeList{
                s += dic[nickName]! + "\t"
                s += dic[realName]! + "\t"
                s += dic[type]! + "\n"
            }
            try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            return
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
