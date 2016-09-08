//
//  ViewController.swift
//  CollectionView
//
//  Created by Acttos on 7/9/2016.
//  Copyright © 2016 Acttos.org. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - DataSource Methods of UICollectionView
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7;
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! CollectionViewCell;
        
        if (indexPath.section % 2 == 0) {
            cell.backgroundImageView.image = UIImage.init(data: NSData(contentsOfURL: NSURL(string: "https://avatars2.githubusercontent.com/u/6056509?v=3&s=460")!)!);
        } else {
            cell.backgroundImageView.image = UIImage(named: "wechat.png");
        }
        
        return cell;
    }
    //MARK: - Delegate Methods of UICollectionView
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("The cell at section : \(indexPath.section), row : \(indexPath.row) has been clicked....");
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell: CollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell;
        let frame: CGRect = cell.backgroundImageView.frame;
        cell.backgroundImageView.frame = CGRectMake(frame.origin.x + 4, frame.origin.y + 4, frame.size.width - 8, frame.size.height - 8);
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell: CollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! CollectionViewCell;
        let frame: CGRect = cell.backgroundImageView.frame;
        cell.backgroundImageView.frame = CGRectMake(frame.origin.x - 4, frame.origin.y - 4, frame.size.width + 8, frame.size.height + 8);
    }
}

