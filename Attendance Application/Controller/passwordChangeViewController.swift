//
//  passwordChangeViewController.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 14/09/23.
//

import UIKit

class passwordChangeViewController: UIViewController {
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmNewPasswordTextField: UITextField!

    var emailID : String = ""
    
    var oldPassword : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func submitButton(_ sender: Any) {
        if oldPasswordTextField.text == oldPassword {
            let fetch = Users.fetchRequest()
            fetch.predicate = NSPredicate(format: "email=%@", emailID)
            do {
                let result = try context.fetch(fetch)
                if (newPasswordTextField.text == confirmNewPasswordTextField.text) && (newPasswordTextField.text != oldPassword){
                    result.first?.password = confirmNewPasswordTextField.text
                    try context.save()
                    let alert = UIAlertController(title: "SUCCESS", message: "Password changed",preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default ,handler: { UIAlertAction in
                        let signIn = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") as! signInViewController
                        self.navigationController?.pushViewController(signIn, animated: true)
                        
                    }))
                    self.present(alert, animated: true)
                }
                else {
                    let alert = UIAlertController(title: "ERROR", message: "New Password doesn't match Confirm New Password", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default))
                    present(alert, animated: true)
                }
            }
            catch {
                print("ERROR")
            }
        }
        else {
            let alert = UIAlertController(title: "ERROR", message: "Old Password is not match", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
            present(alert, animated: true)
        }
    }
}
