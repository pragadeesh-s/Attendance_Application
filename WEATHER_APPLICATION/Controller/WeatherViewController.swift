//
//  ViewController.swift
//  WEATHER_APPLICATION
//
//  Created by Pragadeesh S on 11/02/23.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController,ChangeCityDelegate {
    
    //API Caller
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&appid=55c2203c9dcbd2044afb12a7afd6c9aa"
    
    let weatherDataModel = WeatherDataModel()
    
    @IBOutlet weak var WeatherView: UIView!
    @IBOutlet weak var ViewImage: UIImageView!
    @IBOutlet weak var Citylabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var ClimateLabel: UILabel!
    @IBOutlet weak var iconName: UILabel!
    @IBOutlet weak var weatherimage: UIImageView!
    @IBOutlet weak var SegmentedControl: UISegmentedControl!
    @IBOutlet weak var NextButton: UIButton!
    @IBOutlet weak var WeatherDetails: UILabel!
    @IBOutlet weak var Realfeel: UILabel!
    @IBOutlet weak var feelslike: UILabel!
    @IBOutlet weak var Humidity: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var Windspeed: UILabel!
    @IBOutlet weak var windspeedLabel: UILabel!
    @IBOutlet weak var Pressure: UILabel!
    @IBOutlet weak var PressureLabel: UILabel!
    @IBOutlet weak var DateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEnteredANewCityName(city: "Thanjavur")
        Display()
    }
    
    
    func Display()
    {
        WeatherDetails.Label()
        Realfeel.Label()
        feelslike.Label()
        Humidity.Label()
        humidityLabel.Label()
        Windspeed.Label()
        windspeedLabel.Label()
        Pressure.Label()
        PressureLabel.Label()
        WeatherView.View()
        ViewImage.ImageView()
        NextButton.ButtonDisplay()
        Citylabel.Label()
        tempLabel.Label()
        iconName.Label()
        ClimateLabel.Label()
        weatherimage.ImageView()
        DateLabel.Label()
    }
    
    // MARK: NETWORKING FOR WEATHERMONITOR
    
    func getWeatherData(url: String){
        
        AF.request(url, method: .get).responseJSON { response in
            print(response)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON from server response: \(json)")
                self.updateWeatherData(json: json)
                break
                
            case .failure(let error):
                print("Connection Issues")
                print(error)
                self.Citylabel.text = "Check Internet"
            }
        }
    }
    
    
    // MARK: JSON PARSING
    
    func updateWeatherData(json: JSON){
        
        if let weatherCondition = json["weather"][0]["id"].int {
            weatherDataModel.temperature = json["main"]["temp"].int
            weatherDataModel.city = json["name"].string
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherCondition)
            weatherDataModel.weatherDescription = json["weather"][0]["description"].string
            weatherDataModel.weatherName = json["weather"][0]["main"].string
            weatherDataModel.Feelslike = json["main"]["feels_like"].int
            weatherDataModel.Humdiity = json["main"]["humidity"].int
            weatherDataModel.WindSpeed = json["wind"]["speed"].double
            weatherDataModel.Pressure = json["main"]["pressure"].int
            weatherDataModel.messageError = json["message"].string
            
            updateUIWithWeatherData()
        }
        else {
            weatherDataModel.messageError = json["message"].string
            Citylabel.text = weatherDataModel.messageError?.uppercased()
            print(json)
            if Citylabel.text == "CITY NOT FOUND" {
                let alert = UIAlertController(title: "WRONG CITY NAME", message: "Correct a name of the city", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                    self.performSegue(withIdentifier: "changeCityName", sender: self)
                })
                present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: UI UPDATES
    
    func updateUIWithWeatherData(){
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        let mmyy = dateFormatter.string(from: date)
        
        Citylabel.text = weatherDataModel.city?.uppercased()
        iconName.text = weatherDataModel.weatherDescription?.uppercased()
        ClimateLabel.text = weatherDataModel.weatherName?.uppercased()
        weatherimage.image = UIImage(named: weatherDataModel.weatherIconName!)
        tempLabel.text = "\(weatherDataModel.temperature!)°"
        feelslike.text = "\(weatherDataModel.Feelslike!)°"
        humidityLabel.text = "\(weatherDataModel.Humdiity!)%"
        windspeedLabel.text = "\(weatherDataModel.WindSpeed!)km/h"
        PressureLabel.text = "\(weatherDataModel.Pressure!)mbar"
        DateLabel.text = mmyy
        
        
    }
    
    // MARK: SEGMENTED CONTROL
    
    @IBAction func tempconverter(_ sender: Any) {
        
        switch SegmentedControl.selectedSegmentIndex
        {
        case 0:
            tempLabel.text = "\(weatherDataModel.temperature!)°"
            feelslike.text = "\(weatherDataModel.Feelslike!)°"
        case 1:
            tempLabel.text = "\(weatherDataModel.temperature! * 9 / 5 + 32)°"
            feelslike.text = "\(weatherDataModel.Feelslike! * 9 / 5 + 32)°"
        default:
            break
        }
        
        
    }
    
    
    // MARK: CHANGE CITY DELEGATE METHODS
    
    func userEnteredANewCityName(city: String) {
        let urlString = "\(weatherURL)&q=\(city)"
        getWeatherData(url: urlString)
    }
    
    // MARK: PERFORM SEGUE
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! CitySearchViewController
            destinationVC.delegate = self
        }
    }
}

