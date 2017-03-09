//
//  ModelExtensions.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit
import CloudKit

enum PostError: Error {
    case writingImage
    case createCKRecord
}

extension Post {
    class func recordWith(_ post: Post) throws -> CKRecord? {
        let imageURL = URL.imageURL()
        guard let data = UIImageJPEGRepresentation(post.image, 0.7) else { throw PostError.writingImage }
        
        let saved = (try? data.write(to: imageURL, options: [.atomic])) != nil
        
        if saved {
            let asset = CKAsset(fileURL: imageURL)
            let record = CKRecord(recordType: "Post")
            record.setObject(asset, forKey: "image")
            
            return record
        } else {
            throw PostError.createCKRecord
        }
    }
}
