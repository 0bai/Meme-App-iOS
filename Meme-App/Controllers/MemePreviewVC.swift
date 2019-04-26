//
//  MemePreviewVC.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 4/24/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

class MemePreviewVC: UIViewController{
    
    @IBOutlet weak var previewImage: UIImageView!
    
    
    var meme: Meme!
    
    override func viewWillAppear(_ animated: Bool) {
         previewImage.image = meme.memedImage
    }
    
}
