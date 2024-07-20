//
//  ViewController.swift
//  Weather
//
//  Created by user228347 on 7/16/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelCondition: UILabel!
    
    @IBOutlet weak var labelTemperature: UILabel!
    
    @IBOutlet weak var labelHumidity: UILabel!
    
    @IBOutlet weak var labelWind: UILabel!
    
    @IBOutlet weak var imgViewCondition: UIImageView!
    
    @IBOutlet weak var labelMin: UILabel!
    
    @IBOutlet weak var labelMax: UILabel!
    
    
    var latitude = "43.4668"
    var longitude = "-80.5164"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    
    func render(){
        getTheClimateIn(latitude: "43.4668", longitude: "-80.5164") { weather, error in
            if let error = error {
                print("Erro ao obter o clima: \(error.localizedDescription)")
            } else if let weatherObj = weather {
                print(weatherObj)
                DispatchQueue.main.async {
                    
                    self.labelAddress.text = weatherObj.name
                    
                    self.labelCondition.text = weatherObj.weather.first?.main
                    
                    self.labelTemperature.text = "\(String(format: "%.2f",weatherObj.main.temp))º"
                    
                    
                    self.labelMin.text = "\(String(format: "%.2f",weatherObj.main.tempMin))º"
                    
                    self.labelMax.text = "\(String(format: "%.2f", weatherObj.main.tempMax))º"
                    
                    self.labelHumidity.text = "Humidity:\(weatherObj.main.humidity)%"
                                    
                    self.labelWind.text = "Wind:\(String(format: "%.2f",weatherObj.wind.speed*3.6)) Km/h"
                                    
                    self.imgViewCondition.image = imageForWeatherCondition(icon: weatherObj.weather.first!.icon)
                    
                    let backgroundImage = UIImageView(frame: UIScreen.main.bounds);  backgroundImage.image = backgroundForWeatherCondition(icon: weatherObj.weather.first!.icon)
                    backgroundImage.contentMode = .scaleAspectFill
                    self.view.insertSubview(backgroundImage, at: 0)
                
                    
                    
                }
            }
        }
    }
}

