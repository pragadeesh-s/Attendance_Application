//
//  signUpViewController.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 13/09/23.
//

import UIKit
import CoreData

class signUpViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var userSelectedImage = UIImage()
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var chooseImageButton: UIButton!
    
    @IBOutlet weak var signUpView: UIView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signInNavigate: UIButton!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.UIdisplay()
        signUpButton.buttonDisplay()
        
    }
    
    @IBAction func chooseImageButtonAction(_ sender: Any) {
        let picker = UIImagePickerController ()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        picker.view.layoutIfNeeded()
        present(picker, animated: true)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        userSelectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage ?? UIImage(named: "checked")!
        userImageView?.image = userSelectedImage
        picker.dismiss(animated: true,completion: nil)
    }
    
    
    
    
    @IBAction func signInNavigate(_ sender: Any) {
        let signIn = storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
        self.navigationController?.pushViewController(signIn, animated: true)
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        guard let entity = NSEntityDescription.entity(forEntityName: "Users", in: context) else { return }
        let newObject = NSManagedObject(entity: entity, insertInto: context)
        if (usernameTextField.text != "" && passwordTextField.text != "" && emailTextField.text != "" ) {
            if (userImageView.image != nil) {
                if isValidEmail(emailTextField.text!)
                {
                    let fetch = Users.fetchRequest()
                    fetch.predicate = NSPredicate(format: "username=%@", usernameTextField.text!)
                    fetch.predicate = NSPredicate(format: "email=%@", emailTextField.text!)
                    do {
                        let result = try context.fetch(fetch)
                        if result.isEmpty {
                            newObject.setValue(usernameTextField.text, forKey: "username")
                            newObject.setValue(emailTextField.text, forKey: "email")
                            newObject.setValue(passwordTextField.text, forKey: "password")
                            let imageToData = userSelectedImage.pngData()
                            newObject.setValue(imageToData, forKey: "photo")
                            try context.save()
                            usernameTextField.text = ""
                            emailTextField.text = ""
                            passwordTextField.text = ""
                            passwordTextField.resignFirstResponder()
                            let alert = UIAlertController(title: "SUCCESS", message: "Account Successfully Created",preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .default ,handler: { UIAlertAction in
                                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
                                self.navigationController?.pushViewController(signIn, animated: true)
                                
                            }))
                            self.present(alert, animated: true)
                        }
                        else {
                            let alert = UIAlertController(title: "OOPS!", message: "Account Already Exist", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "Okay", style: .default ,handler: { UIAlertAction in
                                let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
                                self.navigationController?.pushViewController(signIn, animated: true)
                                
                            }))
                            self.present(alert, animated: true)
                        }
                    }
                    catch {
                        print("ERROR")
                    }
                }
                else {
                    self.showAlert(title: "ERROR", message: "Invalid Email Format")
                }
            }
            else {
                self.showAlert(title: "ERROR!", message: "Image is not selected")
            }
            
        }
        else {
            self.showAlert(title: "ERROR!", message: "Username,Email or Password Field cannot be empty")
        }
    }
}

extension signUpViewController {
    
    func showAlert(title:String,message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default))
        present(alert, animated: true)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}
