//
//  HomeViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, Setup, UIImagePickerControllerDelegate, UINavigationControllerDelegate, FiltersPreviewViewControllerProtocol {
    
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var imagePicker = UIImagePickerController()
    
    func setup() {
        self.navigationItem.title = "InstantGraham"
    }
    
    func setupAppearance() {
        self.imageView.layer.cornerRadius = 0
    }
    
    func presentActionSheet() {
        let actionSheet = UIAlertController(title: "Source",
                                            message: "Please select the image source",
                                            preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera",
                                         style: .default) {(action) in self.presentImagePicker(.camera)
        }
        let photoAction = UIAlertAction(title: "Photos",
                                        style: .default) {(action) in self.presentImagePicker(.photoLibrary)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(cameraAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func presentImagePicker(_ sourceType: UIImagePickerControllerSourceType) {
        self.imagePicker.delegate = self
        self.imagePicker.sourceType = sourceType
        self.present(self.imagePicker,
                                   animated: true,
                                   completion: nil)
    }
    
    //MARK: UIImagePickerControllerDeligate
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == FiltersPreviewViewController.identifier() {
            let previewViewController = segue.destination as! FiltersPreviewViewController
            previewViewController.post = sender as! Post
            previewViewController.delegate = self
        }
    }
    
    @IBAction func addButtonSelected(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.presentActionSheet()
        } else {
            self.presentImagePicker(.photoLibrary)
        }
    }
    
    @IBAction func editButtonSelected(_ sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        self.performSegue(withIdentifier: FiltersPreviewViewController.identifier(), sender: Post(image: image))
    }
    
    @IBAction func saveButtonSelected(_ sender: AnyObject) {
        guard let image = self.imageView.image else { return }
        API.shared.write(Post(image: image)) { (success) in
            if success {
                print("save successful")
            }
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imageView.image = UIImage.resize(image, size: CGSize(width: 500, height: 500))
        Filters.original = image
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.setupAppearance()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func filtersPreviewViewControllerDidFinish(_ image: UIImage) {
        self.imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}
