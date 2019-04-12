//
//  ViewController.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 3/15/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit
struct Meme {
    var topText: String
    var bottomText: String
    var originalImage: UIImage
    var memedImage: UIImage
}
class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {


    
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var shareBT: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTF: UITextField!
    @IBOutlet weak var bottomTF: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        let memeTextAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0
        ]
        
        topTF.defaultTextAttributes = memeTextAttributes
        bottomTF.defaultTextAttributes = memeTextAttributes
        
        topTF.textAlignment = .center
        bottomTF.textAlignment = .center
        
        topTF.delegate = self
        bottomTF.delegate = self
        
        initUI()

    }
    
    func initUI(){
        topTF.text = "TOP"
        bottomTF.text = "BOTTOM"
        shareBT.isEnabled = false
        imageView.image = nil
    }
    
    @IBAction func cancel(_ sender: Any) {
       initUI()
    }
    
    @IBAction func share(_ sender: Any) {
        
        let activityController = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = {(activityType: UIActivity.ActivityType?, completed: Bool, returnedItems: [Any]?, error: Error?) in
            self.save()
        }
        
        present(activityController, animated: true, completion: nil)
        
        if let popover = activityController.popoverPresentationController {
            popover.sourceView = self.view
        }

    }
    
    func save() {
        let memedImage = generateMemedImage()
        // Create the meme
        _ = Meme(topText: topTF.text!, bottomText: bottomTF.text!, originalImage: imageView.image!, memedImage: memedImage)
    }
    
    func generateMemedImage() -> UIImage {
        
        toolbar.isHidden = true
        navbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolbar.isHidden = false
        navbar.isHidden = false
        
        return memedImage
    }

}

