//
//  ScoreTableViewController.swift
//  00357035_final
//
//  Created by mari on 2017/6/17.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class ScoreTableViewController: UITableViewController {

    var photoList = [String]()
    var fileManager = FileManager()
    var docUrls = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fileManager = FileManager.default
        docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        loadList()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadList()
        self.tableView.reloadData()
    }
    
    func loadList(){
        let tempList = photoList
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("photoList.txt")
        
        do{
            photoList.removeAll()
            let content = try String(contentsOf: url!, encoding: String.Encoding.utf8)
            for line in content.components(separatedBy: "\n"){
                if line.characters.count != 0{
                    photoList.append(line)
                }
            }
        }
        catch{
            print("read failed")
            let s = ""
            do{
                try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
            }
            catch{}
            photoList = tempList
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! ScoreTableViewCell
        let s = photoList[indexPath.row]
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(s.decomposedStringWithCanonicalMapping + ".png")
        
        cell.photo_text.text = s
        do{
            let data = try Data(contentsOf: url!)
            cell.photo_icon.image = UIImage(data: data)
        }catch{
        }
        return cell
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
            let s = photoList[indexPath.row]
            photoList.remove(at: indexPath.row)
            saveList()
            do{
                let docUrl = docUrls.first
                let url = docUrl?.appendingPathComponent(s.decomposedStringWithCanonicalMapping + ".png")
                try fileManager.removeItem(at: url!)
            }catch{
                print("remove failed")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }    
    }
    
    func saveList(){
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("photoList.txt")
        var s = ""
        for line in photoList{
            s += line + "\n"
        }
        do{
            try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
        }catch{}
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

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewSegue" {
            let next = segue.destination as! PhotoViewController
            let index = tableView.indexPathForSelectedRow?.row
            next.photoName = photoList[index!]
        } else if segue.identifier == "addSegue" {
            let next = segue.destination as! AddPhotoViewController
            next.photoList = photoList
        }
    }
 

}
