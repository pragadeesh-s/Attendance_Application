//
//  signInController.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 13/09/23.
//

import UIKit

class signInViewController: UIViewController {
    
    @IBOutlet weak var signInView: UIView!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpNavigate: UIButton!
    
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signInView.UIdisplay()
        signInButton.buttonDisplay()
    }
    
    @IBAction func signUpNavigate(_ sender: Any) {
        let signUp = storyboard?.instantiateViewController(withIdentifier: "signUpViewController") as! signUpViewController
        self.navigationController?.pushViewController(signUp, animated: true)
    }
    
    
    @IBAction func signInButton(_ sender: Any) {
        
        if emailTextField.text != "" && passwordTextField.text != "" && isValidEmail(emailTextField.text!) {
            let fetch = Users.fetchRequest()
            fetch.predicate = NSPredicate(format: "email=%@", emailTextField.text!)
            do {
                let result = try context.fetch(fetch)
                if result.isEmpty {
                    self.showAlert(title: "Sorry", message: "Couldn't find your Account!\nCreate a Account First")
                }
                else {
                    if result.first?.password == passwordTextField.text {
                        let form = storyboard?.instantiateViewController(withIdentifier: "formViewController") as! formViewController
                        form.username = (result.first?.username)!
                        form.emailID = (result.first?.email)!
                        self.navigationController?.pushViewController(form, animated: true)
                    }
                    else {
                        self.showAlert(title: "ERROR", message: "Invalid Password")
                    }
                }
            }
            catch {
                print("COULD NOT FETCH THE DATA'S!")
            }
        }
        else if emailTextField.text == "" || passwordTextField.text == "" {
            self.showAlert(title: "ERROR!", message: "Username or Password Field cannot be empty")
        }
        else {
            self.showAlert(title: "ERROR!", message: "Invalid Email Format")
        }
    }
    
    @IBAction func forgotButton(_ sender: Any) {
        let forgot = storyboard?.instantiateViewController(withIdentifier: "forgotPasswordViewController") as! forgotPasswordViewController
        self.navigationController?.pushViewController(forgot, animated: true)
    }
}


extension signInViewController {
    
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
    
    func isValidPassword(_ password: String) -> Bool {
        let passwordRegEx = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$%^&*()\\-_=+{}|?>.<,:;~`’]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
    
}
