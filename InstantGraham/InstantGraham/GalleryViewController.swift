//
//  GalleryViewController.swift
//  InstantGraham
//
//  Created by David Livingstone on 6/24/16.
//  Copyright © 2016 David Livingstone. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var colletionView: UICollectionView!
    
    var posts = [Post]() {
        didSet {
            self.colletionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupGalleryViewController()
        self.setupCollectionView()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ImageCollectionViewCell.identifier(), forIndexPath: indexPath) as! ImageCollectionViewCell
        let post = posts[indexPath.row]
        cell.post = post
        
        return cell
    }
    
    func setupGalleryViewController() {
        self.navigationItem.title = "Gallery"
    }
    
    func setupCollectionView() {
        self.colletionView.collectionViewLayout = GalleryCustomLayout(columns: 3)
    }
    
    func update() {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner)
        
        API.shared.GET { (posts) -> () in
            if let posts = posts {
                self.posts = posts
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
