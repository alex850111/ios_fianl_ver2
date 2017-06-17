//
//  PhotoViewController.swift
//  00357035_final
//
//  Created by mari on 2017/6/17.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var myTopBar: UINavigationItem!
    
    var photoName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent(photoName.decomposedStringWithCanonicalMapping + ".png")
        do{
            let data = try Data(contentsOf: url!)
            photoView.image = UIImage(data: data)
        }catch{}
        
        
        myTopBar.title = photoName
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
