//
//  NoteViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/29.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    
    @IBOutlet weak var storeImage: UIImageView!
    
    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Note"
    }
    
    @IBAction func btnPhotoClicked(_ sender: Any) {
        
        photoLibrary()
        
    }

    @IBAction func btnCameraClicked(_ sender: Any) {
        
        camera()
    }
    
    func camera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self ;
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
        
    }
    
    func photoLibrary() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self ;
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    
    deinit {
        print("NoteViewController deinit")
    }
}

extension NoteViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if  let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage  {
            print("width:\( image.size.width ); height:\( image.size.height )")
            
            self.storeImage.image = image
          
            if picker.sourceType == .camera{
                
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                
            }
            
          
        }else{
            print("image is nil")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    }
    
}
