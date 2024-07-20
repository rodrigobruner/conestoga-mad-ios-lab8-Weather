//
//  ViewController.swift
//  Weather
//
//  Created by user228347 on 7/16/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    var latitude = "43.4668"
    var longitude = "-80.5164"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        callAPI()
        // Do any additional setup after loading the view.
    }
    
    func callAPI(){
        
        let urlSession = URLSession(configuration: .default)
        let apiToken = Constants.WeatherAPI.keyAPI;
        let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiToken)")
        print(url)
        
        if let url = url {
            let dataTask = urlSession.dataTask(with: url) { (data,response,error) in
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                    do{
                        let weather = try jsonDecoder.decode(WeatherRequest.self, from: data)
                        print(weather.main.temp)
                        print(weather.coord.lat)
                        print(weather.coord.lon)
                    } catch let error{
                        print(String(describing: error))
                        print(error.localizedDescription)
                    }
                }
            }
            dataTask.resume()
        }
    }


}

