//
//  API.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit
import CloudKit

typealias APICompletion = (_ success: Bool) -> ()

class API {
    static let shared = API()
    
    let container: CKContainer
    let dbase: CKDatabase
    
    fileprivate init(){
        self.container = CKContainer.default()
        self.dbase = self.container.privateCloudDatabase
    }
    
    func write(_ post: Post, completion: @escaping APICompletion) {
        do {
            if let record = try Post.recordWith(post) {
                self.dbase.save(record, completionHandler: { (record, error) in
                    if error == nil && record != nil{
                        completion(true) // deleted success:
                    }
                })
            }
        } catch { print(error) }
    }
    
    func GET(_ completion: @escaping (_ posts: [Post]?) -> ()) {
        let query = CKQuery(recordType: "Post", predicate: NSPredicate(value: true))
        self.dbase.perform(query, inZoneWith: nil) { (records, error) -> Void in
            
            print(error as Any)
            
            if let records = records {
                var posts = [Post]()
                
                for record in records {
                    guard let asset = record["image"] as? CKAsset? else { return }
                    guard let path = asset?.fileURL.path else { return }
                    guard let image = UIImage(contentsOfFile: path) else { return }
                    
                    posts.append(Post(image: image))
                }
                
                OperationQueue.main.addOperation{ () -> Void in
                    completion(posts)
                }
            }
        }
    }
}
