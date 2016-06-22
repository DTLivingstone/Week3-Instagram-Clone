//
//  Post.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

import UIKit
class Post {
    let image : UIImage
    
    init( image: UIImage) {
        self.image = image
    }
}

extension NSURL {
    static func imageURL() -> NSURL {
        guard let documentDirectory = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first else {
            fatalError("error getting document")
        }
        return documentDirectory.URLByAppendingPathComponent("image")
    }
}