//
//  SentMemesCollectionVC.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 4/24/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

class SentMemesCollectionVC: UIViewController{
    
    @IBOutlet weak var collection: UICollectionView!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collection.reloadData()
    }
    
}

extension SentMemesCollectionVC: UICollectionViewDataSource, UICollectionViewDelegate{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CMemeCell", for: indexPath) as! MemeCollectionCell
        
        cell.meme = memes[indexPath.row]
        cell.tag = indexPath.row
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "CollectionToPreview", sender: collectionView.cellForItem(at: indexPath))
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionToPreview" {
            let previewVC = segue.destination as! MemePreviewVC
            let cell = sender as! MemeCollectionCell
            previewVC.meme = memes[cell.tag]
        }
    }


    
}
