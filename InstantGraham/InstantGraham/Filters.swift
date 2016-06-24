//
//  Filters.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (theImage: UIImage?) -> ()

class Filters {
    
    static let shared = Filters()
    private init(){
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        self.context = CIContext(EAGLContext: eAGContext, options: options)
    }
    
    let context: CIContext
    
    static var original = UIImage() //save original in case user wants to revert changes
    
    private func filter(name: String, image: UIImage, completion: FiltersCompletion){
        
        NSOperationQueue().addOperationWithBlock {
            
            guard let filter = CIFilter(name: name) else { fatalError("filter does not exist") }
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            
            
            guard let outputImage = filter.outputImage else { fatalError("error rendering image") }
            
            let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
                completion(theImage: UIImage(CGImage: cgImage))
                
            })
        }
    }
    
    func originalImage(image: UIImage, completion: FiltersCompletion) {
        completion(theImage: Filters.original)
    }
    
    func bw(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func dotScreen(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIDotScreen", image: image, completion: completion)
    }
    
    func crystallize(image: UIImage, completion: FiltersCompletion) {
        self.filter("CICrystallize", image: image, completion: completion)
    }
}