//
//  forgotPasswordViewController.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 14/09/23.
//

import UIKit

class forgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var forgotImage: UIImageView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var Send: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        UIDisplays()
       
    }
    
    func UIDisplays(){
        contentView.layer.cornerRadius = 20
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        contentView.layer.shadowOpacity = 0.6
    }
    
    
    @IBAction func sendButton(_ sender: Any) {
        if emailTextField.text != "" {
            let fetch = Users.fetchRequest()
            fetch.predicate = NSPredicate(format: "email=%@", emailTextField.text!)
            do{
                let result = try context.fetch(fetch)
                if !(result.isEmpty) {
                    let change = storyboard?.instantiateViewController(withIdentifier: "passwordChangeViewController") as! passwordChangeViewController
                    change.emailID = (result.first?.email)!
                    change.oldPassword = (result.first?.password)!
                    self.navigationController?.pushViewController(change, animated: true)
                }
            }
            catch{
                print("ERROR")
            }
        }
    }
}
