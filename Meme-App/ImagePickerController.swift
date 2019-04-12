//
//  ImagePickerController.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 4/12/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

extension ViewController{
    
    @IBAction func showImagePicker(_ sender: Any) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = (sender as AnyObject).tag == 0 ? .photoLibrary : .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //save the image
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
        }
        
        shareBT.isEnabled = true
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
