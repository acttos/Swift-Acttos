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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3;
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell;
        
        if ((indexPath as NSIndexPath).section % 2 == 0) {
            cell.backgroundImageView.image = UIImage.init(data: try! Data(contentsOf: URL(string: "https://avatars2.githubusercontent.com/u/6056509?v=3&s=460")!));
        } else {
            cell.backgroundImageView.image = UIImage(named: "wechat.png");
        }
        
        return cell;
    }
    //MARK: - Delegate Methods of UICollectionView
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NSLog("The cell at section : \((indexPath as NSIndexPath).section), row : \((indexPath as NSIndexPath).row) has been clicked....");
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell: CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell;
        let frame: CGRect = cell.backgroundImageView.frame;
        cell.backgroundImageView.frame = CGRect(x: frame.origin.x + 4, y: frame.origin.y + 4, width: frame.size.width - 8, height: frame.size.height - 8);
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell: CollectionViewCell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell;
        let frame: CGRect = cell.backgroundImageView.frame;
        cell.backgroundImageView.frame = CGRect(x: frame.origin.x - 4, y: frame.origin.y - 4, width: frame.size.width + 8, height: frame.size.height + 8);
    }
}

