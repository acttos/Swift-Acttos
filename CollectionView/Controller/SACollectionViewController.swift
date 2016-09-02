//
//  SACollectionViewController.swift
//  Swift-Acttos
//
//  Created by Actto on 29/8/2016.
//  Copyright © 2016 Personal. All rights reserved.
//

import UIKit

class SACollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //If you design your interface using 'Storyboard', make sure not to invoke this line below:
//        self.collectionView.registerClass(SACollectionViewCell.self, forCellWithReuseIdentifier: "SACollectionViewCell");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - Datasource Methods of CollectionViewController
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1;
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 22;
    }

    func  collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell: SACollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("SACollectionViewCell", forIndexPath: indexPath) as! SACollectionViewCell;
        
        return cell;
    }
    //MARK: - Delegate Methods of CollectionViewController
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        NSLog("Cell @ \(indexPath) clicked...");
    }
    
    func collectionView(collectionView: UICollectionView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell: SACollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! SACollectionViewCell;
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y + 4, cell.frame.size.width, cell.frame.size.height);
    }
    
    func collectionView(collectionView: UICollectionView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        let cell: SACollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! SACollectionViewCell;
        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y - 4, cell.frame.size.width, cell.frame.size.height);
    }
}
