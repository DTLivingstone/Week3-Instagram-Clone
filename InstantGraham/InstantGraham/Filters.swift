//
//  Filters.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/21/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

typealias FiltersCompletion = (_ theImage: UIImage?) -> ()

class Filters {
    
    static let shared = Filters()
    fileprivate init(){
        let options = [kCIContextWorkingColorSpace: NSNull()]
        let eAGContext = EAGLContext(api: EAGLRenderingAPI.openGLES2)
        self.context = CIContext(eaglContext: eAGContext!, options: options)
    }
    
    let context: CIContext
    
    static var original = UIImage() //save original in case user wants to revert changes
    
    fileprivate func filter(_ name: String, image: UIImage, completion: @escaping FiltersCompletion){
        
        OperationQueue().addOperation {
            
            guard let filter = CIFilter(name: name) else { fatalError("filter does not exist") }
            
            filter.setValue(CIImage(image: image), forKey: kCIInputImageKey)
            
            
            
            guard let outputImage = filter.outputImage else { fatalError("error rendering image") }
            
            let cgImage = self.context.createCGImage(outputImage, from: outputImage.extent)
            
            OperationQueue.main.addOperation({
                
                completion(UIImage(cgImage: cgImage!))
                
            })
        }
    }
    
    func originalImage(_ image: UIImage, completion: FiltersCompletion) {
        completion(Filters.original)
    }
    
    func bw(_ image: UIImage, completion: @escaping FiltersCompletion) {
        self.filter("CIPhotoEffectMono", image: image, completion: completion)
    }
    
    func dotScreen(_ image: UIImage, completion: @escaping FiltersCompletion) {
        self.filter("CIDotScreen", image: image, completion: completion)
    }
    
    func crystallize(_ image: UIImage, completion: @escaping FiltersCompletion) {
        self.filter("CICrystallize", image: image, completion: completion)
    }
}
