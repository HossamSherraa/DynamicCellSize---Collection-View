//
//  CollectionViewController.swift
//  DynamicCellSize
//
//  Created by Hossam on 9/26/19.
//  Copyright © 2019 Hossam. All rights reserved.
//

import UIKit
class CollectionViewController : UICollectionViewController {
    let layout = DynamicLayout()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.collectionViewLayout = layout
    }
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DATA.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! MyCell
        cell.textLabel.text = DATA[indexPath.row]
       
        
        return cell
    }
    
}
