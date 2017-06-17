//
//  AddPhotoViewController.swift
//  00357035_final
//
//  Created by mari on 2017/6/17.
//  Copyright © 2017年 user_05. All rights reserved.
//

import UIKit

class AddPhotoViewController: UITableViewController, UIImagePickerControllerDelegate,
    UINavigationControllerDelegate{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var photoPreview: UIImageView!
    
    var selectedImage = UIImage()
    var isPhotoSelected = Bool()
    var photoList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem?.title = "Cancel"
        isPhotoSelected = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        print(info)
        selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoPreview.image = selectedImage
        isPhotoSelected = true
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SelectPhotoButton(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
    }
    
    @IBAction func Done(_ sender: Any) {
        var name = nameField.text!
        //if text field is empty
        if name.characters.count == 0{
            let controller = UIAlertController(title: "", message: "please input title for this photo", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in})
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
            return
        }
        //if no photo have been selected
        if isPhotoSelected == false{
            let controller = UIAlertController(title: "", message: "please select a photo", preferredStyle: UIAlertControllerStyle.alert)
            let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in})
            controller.addAction(action)
            present(controller, animated: true, completion: nil)
            return
        }
        //if this name has been used
        for line in photoList {
            if line == name {
                let controller = UIAlertController(title: "", message: "this title had been used", preferredStyle: UIAlertControllerStyle.alert)
                let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in})
                controller.addAction(action)
                present(controller, animated: true, completion: nil)
                return
            }
        }
        photoList.append(name)
        savePhotoAndList(name: name)
        self.navigationController?.popViewController(animated: true)
    }
    
    func savePhotoAndList(name : String){
        let fileManager = FileManager.default
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        var url = docUrl?.appendingPathComponent("photoList.txt")
        
        do{
            var s = ""
            for line in photoList {
                s += line + "\n"
            }
            try s.write(to: url!, atomically: false, encoding: String.Encoding.utf8)
            print("text over")
            url = docUrl?.appendingPathComponent(name + ".png")
            if let pngImageData = UIImagePNGRepresentation(selectedImage) {
                try pngImageData.write(to: url!, options: .atomic)
                print("image over")
            } else {
                print("convert failed")
            }
        }catch{
            print ("save failed")
        }

    }
    
}
