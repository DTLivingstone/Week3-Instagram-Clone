//
//  ImageCollectionViewCell.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/24/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    var post: Post? {
        didSet {
            self.imageView.image = post?.image
        }
    }
    
    class func identifier() -> String {
        return "ImageCollectionViewCell"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
}
