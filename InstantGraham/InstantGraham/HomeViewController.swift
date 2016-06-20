//
//  HomeViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/20/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: UIImagePickerControllerDeligate
    
    func imagePickerControllerDidCancel() {
        //
    }

    func imagePickerController(picker: UIImagePickerController) {
        //
    }
    
    
}
