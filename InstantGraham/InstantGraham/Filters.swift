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
    
    static var original = UIImage() //save original in case user wants to revert changes
    
    private class func filter(name: String, image: UIImage, completion: FiltersCompletion){
        NSOperationQueue().addOperationWithBlock {
            guard let filter = CIFilter(name: name) else { fatalError("filter does not exist") }
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            let options = [kCIContextWorkingColorSpace: NSNull()]
            let eAGContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
            let gPUContext = CIContext(EAGLContext: eAGContext, options: options)
            
            guard let outputImage = filter.outputImage else { fatalError("error rendering image") }
            
            let cgImage = gPUContext.createCGImage(outputImage, fromRect: outputImage.extent)
            
            NSOperationQueue.mainQueue().addOperationWithBlock({
                
                completion(theImage: UIImage(CGImage: cgImage))
                
            })
        }
    }
    class func dotScreen(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIDotScreen", image: image, completion: completion)
    }
    
    class func blur(image: UIImage, completion: FiltersCompletion) {
        self.filter("CIGaussianBlur", image: image, completion: completion)
    }
    
    class func crystallize(image: UIImage, completion: FiltersCompletion) {
        self.filter("CICrystallize", image: image, completion: completion)
    }
}