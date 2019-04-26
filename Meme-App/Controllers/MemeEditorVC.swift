//
//  ViewController.swift
//  Meme-App
//
//  Created by Obai Alnajjar on 3/15/19.
//  Copyright © 2019 Obai Alnajjar. All rights reserved.
//

import UIKit

class MemeEditorVC: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var navbar: UINavigationBar!
    
    @IBOutlet weak var shareBT: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var topTF: UITextField!
    
    @IBOutlet weak var bottomTF: UITextField!

    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        initUI()
    }
    
    func setupTextField(tf: UITextField, text: String) {
        tf.defaultTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.black,
            NSAttributedString.Key.font : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: -4.0,
        ]
        tf.textColor = UIColor.white
        tf.tintColor = UIColor.white
        tf.textAlignment = .center
        tf.text = text
        tf.delegate = self
    }
    
    func initUI(){
        setupTextField(tf: topTF, text: "TOP")
        setupTextField(tf: bottomTF, text: "BOTTOM")
        shareBT.isEnabled = false
        imageView.image = nil
    }
    
    @IBAction func cancel(_ sender: Any) {
       dismiss(animated: true, completion: nil)
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
        // Create the meme
        let meme = Meme(topText: topTF.text!, bottomText: bottomTF.text!, originalImage: imageView.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        dismiss(animated: true, completion: nil)
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






//TextFields delegates
extension MemeEditorVC{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        if textField.tag == 1 {
            subscribeToKeyboardNotifications()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.tag == 1 {
            unsubscribeFromKeyboardNotifications()
        }
        return true
    }
    
    func subscribeToKeyboardNotifications() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        
        view.frame.origin.y = 0
        
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
}









