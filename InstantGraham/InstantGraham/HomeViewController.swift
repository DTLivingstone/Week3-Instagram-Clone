//
//  HomeViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!

    lazy var imagePicker = UIImagePickerController()
    
    func setup() {
        self.navigationItem.title = "InstantGraham"
    }
    
    func setupAppearance() {
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
    
    func presentImagePicker(sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.presentViewController(self.imagePicker,
                                animated: true,
                                completion: nil)
    }
    
    //MARK: UIImagePickerControllerDeligate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonSelected(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.PhotoLibrary)
        }
    }
}
