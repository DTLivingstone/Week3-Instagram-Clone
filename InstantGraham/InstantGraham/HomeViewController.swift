//
//  HomeViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Setup {

    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker: UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setup() {
        self.navigationItem.title = "InstantGraham"
    }
    
    func setupApperance() {
        self.imageView.layer.cornerRadius = 30
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source",
                                            message: "Please select the image source",
                                            preferredStyle: .ActionSheet)
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .Default) {(action) in self.presentImagePicker(.Camera)
        }
        let photoAction = UIAlertAction(title: "Photos",
                                        style: .Default) {(action) in self.presentImagePicker(.PhotoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerControllerSource) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker,
                                animated: true,
                                completion: nil)
    }
    
    //MARK: UIImagePickerControllerDeligate
    
    func imagePickerControllerDidCancel() {
        //
    }

    func imagePickerController(picker: UIImagePickerController) {
        //
    }
    
    @IBAction func addButtonSelected(sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
    
}
