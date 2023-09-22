//
//  cameraViewController.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 15/09/23.
//

import UIKit

class cameraViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraPreview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func cameraAction(_ sender: Any) {
        let picker = UIImagePickerController ()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        picker.view.layoutIfNeeded()
        present (picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        cameraPreview?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        picker.dismiss (animated: true, completion: nil)
    }
}
