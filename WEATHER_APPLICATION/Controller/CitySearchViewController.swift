//
//  CitySearchViewController.swift
//  WEATHER_APPLICATION
//
//  Created by Pragadeesh S on 11/09/23.
//

import UIKit

class CitySearchViewController: UIViewController, UITextFieldDelegate {
    
    var delegate : ChangeCityDelegate?
    
    @IBOutlet weak var CityNameTextfield: UITextField!
    @IBOutlet weak var GetWeatherButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        CityNameTextfield.delegate = self
        Display()
        
    }
    func Display() {
        CityNameTextfield.TextDisplay()
        GetWeatherButton.ButtonDisplay()
        BackButton.ButtonDisplay()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        CityNameTextfield.resignFirstResponder()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    @IBAction func getWeatherPressed(_ sender: Any) {
        let cityName = CityNameTextfield.text!
        delegate?.userEnteredANewCityName(city: cityName)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

