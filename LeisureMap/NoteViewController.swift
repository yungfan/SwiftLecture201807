//
//  NoteViewController.swift
//  LeisureMap
//
//  Noto
//  撰寫評論，拍照上傳
//
//  Created by 房懷安 on 2018/7/24.
//  Copyright © 2018年 房懷安. All rights reserved.
//

import UIKit
import AZSClient


class NoteViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate{

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var StoreImageView: UIImageView!
    
    
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var txtNoteBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Views' Event
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        txtNote.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            print(keyboardHeight)
            
            
            DispatchQueue.main.async {
                UIView.animate(withDuration: 1.0, animations: {
                    self.txtNoteBottomConstraint.constant = keyboardHeight + 5
                })
            }
            
            
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 1.0, animations: {
                self.txtNoteBottomConstraint.constant = 70
            })
        }
        
    }
    
    @IBAction func btnSelectImageSourceClicked(_ sender: Any) {
        
        //WeiboSDK.share(toWeibo: "App 測試訊息")
        
        showActionSheet()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - SinaWeibo
    
    func shareImageToSina(shareImage image:UIImage) {
        
        let authReq = WBAuthorizeRequest()
        
        authReq.scope = "all"
        
        let message = WBMessageObject()
        message.text = "Test Weibo iOS SDK"
        
        let img = WBImageObject()
        
        //
        let imgData = image.jpegData(compressionQuality: 0.7)
        img.imageData = imgData!
        message.imageObject = img
        
        
        let req: WBSendMessageToWeiboRequest = WBSendMessageToWeiboRequest.request(withMessage: message, authInfo: authReq, access_token: nil) as! WBSendMessageToWeiboRequest
        req.userInfo = ["info": "SDK Testing"] //
        req.shouldOpenWeiboAppInstallPageIfNotInstalled = false
        
        WeiboSDK.send(req)
    }
    
    // MARK: - UIImagePickerController
    
    func showActionSheet() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment:"camera"), style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Gallery", comment:"gallery"), style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("Cancel",comment: "cancel"), style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }

    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self ;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary()
    {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self ;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            print("width:\( image.size.width ); height:\( image.size.height )")
            
            self.StoreImageView.image = image
            
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            
            shareImageToSina(shareImage: image)
        
        }else{
            print("image is nil")
        }
        self.dismiss(animated: true, completion: nil)
    }

    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("")
    }
    
    
}
