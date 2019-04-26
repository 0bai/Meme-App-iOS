//
//  MemeTableCell.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 4/24/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

class MemeTableCell: UITableViewCell {
    
    @IBOutlet weak var imageThumbnail: UIImageView!
    
    @IBOutlet weak var nameTF: UILabel!

    var meme : Meme!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        imageThumbnail.image = meme.memedImage
        nameTF.text = "\(meme.topText.suffix(9))...\(meme.bottomText.prefix(9))"
    }

}
