//
//  ViewController.swift
//  Weather
//
//  Created by user228347 on 7/16/24.
//

import UIKit

import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var labelAddress: UILabel!
    
    @IBOutlet weak var labelCondition: UILabel!
    
    @IBOutlet weak var labelTemperature: UILabel!
    
    @IBOutlet weak var labelHumidity: UILabel!
    
    @IBOutlet weak var labelWind: UILabel!
    
    @IBOutlet weak var imgViewCondition: UIImageView!
    
    @IBOutlet weak var labelMin: UILabel!
    
    @IBOutlet weak var labelMax: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        checkLocationAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    

    func checkLocationAuthorization(){

        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                let alert = UIAlertController(title: "Localization is required", message: "Go to settings and allow this app to get your approximate location, without which we won't be able to give you the weather forecast.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .authorizedAlways, .authorizedWhenInUse:
                break
            @unknown default:
                break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Loc man")
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    
    func render(_ location:CLLocation){
        
            var lat: Double = location.coordinate.latitude ?? 43.4668
            var lon: Double = location.coordinate.longitude ?? -80.5164
        
            getTheClimateIn(latitude: lat, longitude: lon) { weather, error in
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

