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
            displayAlertWindow(title: "", message: "please input title for this photo")
            return
        }
        //if no photo have been selected
        if isPhotoSelected == false{
            displayAlertWindow(title: "", message: "please select a photo")
            return
        }
        //if this name has been used
        for line in photoList {
            if line == name {
                displayAlertWindow(title: "", message: "this title had been used")
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
            url = docUrl?.appendingPathComponent(name + ".png")
            if let pngImageData = UIImagePNGRepresentation(selectedImage) {
                try pngImageData.write(to: url!, options: .atomic)
            } else {
            }
        }catch{
        }

    }
    
    func displayAlertWindow(title: String, message: String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) in})
        controller.addAction(action)
        present(controller, animated: true, completion: nil)
    }
    
}
