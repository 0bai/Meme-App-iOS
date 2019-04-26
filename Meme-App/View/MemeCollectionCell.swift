//
//  MemeCollectionCell.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 4/24/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

class MemeCollectionCell: UICollectionViewCell {
    
   
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    var meme : Meme!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
     imageThumbnail.image = meme.originalImage
    }
}
