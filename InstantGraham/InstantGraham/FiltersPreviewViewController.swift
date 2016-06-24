//
//  FiltersPreviewViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/24/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class FiltersPreviewViewController: UIViewController, UICollectionViewDataSource {
    @IBOutlet weak var collection: UICollectionView!

    let filters = [Filters.shared.originalImage, Filters.shared.bw]
    var post = Post()
    
    class func identifier() -> String {
        return "FiltersPreviewViewController"
    }
    
    func setupCollectionView() {
        self.collection.collectionViewLayout = GalleryCustomLayout(columns: 2)
    }
    
    func configureCellForIndexPath(indexPath: NSIndexPath) -> ImageCollectionViewCell {
        
        let imageCell = self.collection.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier(), forIndexPath: indexPath) as! ImageCollectionViewCell
        
        self.filters[indexPath.row](post.image, completion: {
            
            imageCell.imageView.image = $0
            
        })
        
        return imageCell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

}
