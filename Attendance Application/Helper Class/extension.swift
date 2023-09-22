//
//  extension.swift
//  Attendance Application
//
//  Created by Pragadeesh S on 13/09/23.
//

import Foundation
import UIKit

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

extension UIView {
    func UIdisplay(){
        self.layer.cornerRadius = 20
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        self.layer.shadowOpacity = 1
    }
}

extension UIButton {
    func buttonDisplay(){
        self.layer.cornerRadius = 18
    }
}

extension UILabel {
    func labelDisplay() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
    }
}

extension UIImageView {
    func imageDisplay(){
        self.layer.cornerRadius = 18
    }
}
