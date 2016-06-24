//
//  API.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import Foundation
import CloudKit

typealias APICompletion = (success: Bool) -> ()

class API {
    static let shared = API()
    
    let container: CKContainer
    let dbase: CKDatabase
    
    private init(){
        self.container = CKContainer.defaultContainer()
        self.dbase = self.container.privateCloudDatabase
    }
    
    func write(post: Post, completion: APICompletion) {
        do {
            if let record = try Post.recordWith(post) {
                self.dbase.saveRecord(record, completionHandler: { (record, error) in
                    if error == nil && record != nil{
                        print(record)
                        completion(success: true)
                    }
                })
            }
        } catch { print(error) }
    }
}