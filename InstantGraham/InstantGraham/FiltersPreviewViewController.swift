//
//  FiltersPreviewViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/24/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

protocol FiltersPreviewViewControllerProtocol: class {
    func filtersPreviewViewControllerDidFinish(_ image: UIImage)
}

class FiltersPreviewViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collection: UICollectionView!

    weak var delegate: FiltersPreviewViewControllerProtocol?
    
    let filters = [Filters.shared.originalImage, Filters.shared.bw, Filters.shared.dotScreen, Filters.shared.crystallize]
    var post = Post()
    
    class func identifier() -> String {
        return "FiltersPreviewViewController"
    }
    
    func setupCollectionView() {
        self.collection.collectionViewLayout = GalleryCustomLayout(columns: 2)
    }
    
    func configureCellForIndexPath(_ indexPath: IndexPath) -> ImageCollectionViewCell {
        
        let imageCell = self.collection.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier(), for: indexPath) as! ImageCollectionViewCell
        
        self.filters[indexPath.row](post.image, {
            
            imageCell.imageView.image = $0
            
        })
        
        return imageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return self.configureCellForIndexPath(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ImageCollectionViewCell
        guard let image = cell.imageView.image else { return }
        self.delegate?.filtersPreviewViewControllerDidFinish(image)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }

}
