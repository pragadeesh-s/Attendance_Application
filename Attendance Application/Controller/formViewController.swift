//
//  formViewController.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 14/09/23.
//

import UIKit
import CoreData

class formViewController: UIViewController,UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var attendanceView: UIView!
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var usernameDetails: UILabel!
    
    @IBOutlet weak var emailIDDetails: UILabel!
    
    @IBOutlet weak var dateDetails: UILabel!
    
    @IBOutlet weak var timeDetails: UILabel!
    
    @IBOutlet weak var attendanceDetails: UILabel!
    
    @IBOutlet weak var fullDayLabel: UILabel!
    
    @IBOutlet weak var halfDayLabel: UILabel!
    
    @IBOutlet weak var fullDayButton: UIButton!
    
    @IBOutlet weak var halfDayButton: UIButton!
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBOutlet weak var choosePhotoButton: UIButton!
    
    var isChecked = false
    
    var username : String = ""
    
    var emailID : String = ""
    
    var today = Date()
    
    var userSelectedImage : Data?
    
    var dateString : String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attendanceView.UIdisplay()
        UILabelDisplay()
        submitButton.buttonDisplay()
        userImage.imageDisplay()
        
        usernameDetails.text = username
        emailIDDetails.text = emailID
        
        // timeFormatter used for current time
        let timeFormatter = DateFormatter()
        timeFormatter.timeStyle = .short
        timeDetails.text = timeFormatter.string(from: today)
        
        // dateFormatter used for current date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateString = dateFormatter.string(from: today)
        dateDetails.text = dateFormatter.string(from: today)
    }
    
    func UILabelDisplay(){
        usernameDetails.labelDisplay()
        emailIDDetails.labelDisplay()
        dateDetails.labelDisplay()
        timeDetails.labelDisplay()
        attendanceDetails.labelDisplay()
    }
    
    // photo picker from gallery
    
    @IBAction func choosePhotoButton(_ sender: Any) {
        let picker = UIImagePickerController ()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        picker.view.layoutIfNeeded()
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userImage?.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        userSelectedImage = userImage.image?.pngData()
        picker.dismiss(animated: true,completion: nil)
    }
    
    // submit button
    
    @IBAction func submitButton(_ sender:Any) {
        
        if attendanceDetails.text == "1" || attendanceDetails.text == "1/2" {
            let alert = UIAlertController(title: "Attendance Noted!", message: "Thank You", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default ,handler: { UIAlertAction in
                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
                self.navigationController?.pushViewController(signIn, animated: true)
            }))
            present(alert, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Sorry", message: "Attendance already noted", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default ,handler: { UIAlertAction in
                self.submitButton.isHidden = true
            }))
            present(alert, animated: true)
        }
    }
    
    // signout button
    
    @IBAction func signOutButton(_ sender: Any) {
        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
        self.navigationController?.pushViewController(signIn, animated: true)
    }
    
    // checkbox to check whether full day or half day
    
    @IBAction func checkBox(_ sender: UIButton) {
        
        let fetch = Users.fetchRequest()
        fetch.predicate = NSPredicate(format: "email=%@", emailID)
        do {
            let result = try context.fetch(fetch)
            guard let pic = result.first?.photo else { return }
            if pic == userSelectedImage {
                if UserDefaults.standard.string(forKey: dateString) != dateString {
                    switch sender.tag {
                    case 1:
                        isChecked = !isChecked
                        fullDayButton.setImage(UIImage(named: isChecked ? "checked" : "unchecked"), for: .normal)
                        halfDayButton.setImage(UIImage(named: "unchecked"), for: .normal)
                        attendanceDetails.text = isChecked ? "1" : ""
                        UserDefaults.standard.set(dateDetails.text, forKey: dateString)
                    case 2:
                        isChecked = !isChecked
                        halfDayButton.setImage(UIImage(named: isChecked ? "checked" : "unchecked"), for: .normal)
                        fullDayButton.setImage(UIImage(named: "unchecked"), for: .normal)
                        attendanceDetails.text = isChecked ? "1/2" : ""
                        UserDefaults.standard.set(dateDetails.text, forKey: dateString)
                    default:
                        break
                    }
                }
                else {
                    showAlert(title: "Sorry", message: "Already marked the attendance")
                }
            }
            else {
                showAlert(title: "Error", message: "Image doesn't match")
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}


extension formViewController {
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
}
