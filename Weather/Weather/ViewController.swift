//
//  ViewController.swift
//  Weather
//
//  Created by Hao Lam on 6/13/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//
import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate
{
 
    @IBOutlet weak var temp_label: UILabel!

    @IBOutlet weak var currentLocation_label: UILabel!
    
    @IBOutlet weak var weather_img: UIImageView!
    
    @IBOutlet weak var weatherStatus_label: UILabel!
    
    @IBOutlet weak var weather_table: UITableView!
    
    @IBOutlet weak var background_view: UIView!
    
    let gradientLayer = CAGradientLayer();
    
    let apiKey = "57f8af83529fa861b43943790e049cba"
    var lat = 12.132312
    var long = 123.334010
    var currentLocation:CLLocation? //optional at the begin
  
    var activityIndicator:NVActivityIndicatorView!   // for loading the dialog box
    
    let locationManager = CLLocationManager()
    
    //sample test
    var icon_list2: [String] = ["01d","01n","01d","01d","01d","01d","01n"]
    var temp_list2: [String] = ["20-24", "22-19","22-19","22-19","22-19","22-19","22-19"]
    var day_list2: [String] = ["mon","tue","wed","thur","fri","sat","sun"]
    
    
    var icon_list = [String]()
    var temp_list = [String]()
    var day_list = [String]()
    var dayOfWeek: [String] = ["Sun", "Mon","Tue", "Wed", "Thu", "Fri", "Sat","Sun", "Mon","Tue", "Wed", "Thu", "Fri", "Sat"]
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //get day of the week
        init_day_list()
        // register cell for TableView
        weather_table.register(WeatherTableViewCell.nib(), forCellReuseIdentifier: WeatherTableViewCell.identifier)
        //create table view (NOTE: cell MUST register before use)
        weather_table.delegate = self
        weather_table.dataSource = self
        //Create a gradient layer
        background_view.layer.addSublayer(gradientLayer)
        
        let indicatorSize : CGFloat = 70
        let indicatorFrame = CGRect(x: (view.frame.width - indicatorSize)/2, y: (view.frame.height - indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20)
        activityIndicator.backgroundColor = UIColor.black
        view.addSubview(activityIndicator)

    }
    

  
   //LOCATION:
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         setUpLocation()
         
       
     }
    //Set up location function
    func setUpLocation()
    {
        //get location
       
        locationManager.requestWhenInUseAuthorization()
        activityIndicator.startAnimating()
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
       
        }
        
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        //function will be called whenever the location is updated
        let location = locations[0]
        lat = location.coordinate.latitude
        long = location.coordinate.longitude
        currentForecast_request() // get current weather
        dailyForecast_request () // get day forecast
            
        
        self.locationManager.stopUpdatingLocation()
       
    }
    
    //RETRIEVE WEATHER DATA
   func currentForecast_request()
   {
    // alamofire
    AF.request("http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(apiKey)&units=metric").responseJSON
        {
            response in
            self.activityIndicator.stopAnimating()
            switch response.result
            {
            case .success(let value):
                let jsonResponse = JSON(value)
                let jsonWeather = jsonResponse["weather"].array![0]
                let jsonTemp = jsonResponse["main"]
                let iconName = jsonWeather["icon"].stringValue
                
                self.currentLocation_label.text = jsonResponse["name"].stringValue
                self.weather_img.image = UIImage(named: iconName)
                self.weatherStatus_label.text = jsonWeather["main"].stringValue
                self.temp_label.text = "\(Int(round(jsonTemp["temp"].doubleValue)))"
                
                //check night or day
                let suffix = iconName.suffix(1)
                if (suffix=="n")
                {//night background
                    self.set_MidnightBlue_Background()
                }
                else
                {//day background
                    self.set_LightBlue_Background()
                }
            
            case .failure( _):
                break
            }
        }
    }
    func dailyForecast_request()
    {
        var icons = [String]()
        var temps = [String]()
        AF.request("https://api.openweathermap.org/data/2.5/onecall?lat=\(lat)&lon=\(long)&exclude=minutely,hourly&appid=\(apiKey)&units=metric").responseJSON
               {
                   response in
                   self.activityIndicator.stopAnimating()
                   switch response.result
                   {
                   case .success(let value):
                       let jsonResponse = JSON(value)
                       for item in 0...7
                       {
                        let daily_item = jsonResponse["daily"].array![item]
                        let weather_item = daily_item["weather"].array![0]
                        let icon = weather_item["icon"].stringValue
                        
                        let temp_item = daily_item["temp"]
                        let min = "\(Int(round(temp_item["min"].doubleValue)))"
                        let max = "\(Int(round(temp_item["max"].doubleValue)))"
                        let min_max = min + " - " + max
                        
                        icons.append(icon)
                        temps.append(min_max)
                        
                       }
                       //self.weather_table.reloadData()
                       self.temp_list = temps
                       self.icon_list = icons
                       
                        break
                    
                   case .failure( _):
                       break
                   }
               }
      print ("After get daily forecast: temp_count:\(temp_list.count) ; icon_count: \(icon_list.count)")
    }
    
    //BACKGROUND:
    override func viewWillAppear(_ animated: Bool) {
             set_MidnightBlue_Background()
               
         }
       private func set_MidnightBlue_Background ()
       {
           
           gradientLayer.frame = view.bounds;
           gradientLayer.colors=[UIColor.systemBlue.cgColor, UIColor.black.cgColor]
       }
       func set_LightBlue_Background ()
       {
           gradientLayer.frame = view.bounds;
           gradientLayer.colors=[UIColor.systemBlue.cgColor, UIColor.white.cgColor]
       }
        
    //DAY_LIST INITIALIZE
    func init_day_list()
    {
        // get today
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        let today = dateFormatter.string(from: date)
        self.day_list.append (today + " (today)")
        
        // fill other day of week in day_list
        print (today)
        for index in 0...6
        {
            day_list.append(dayOfWeek[index])
        }
        
    }
  
}
extension ViewController: UITableViewDataSource
{
//TABLEVIEW : Implement basic functionality of the table
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return day_list2.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
   {
        let cell = weather_table.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for:indexPath ) as! WeatherTableViewCell //this allow give access to the properties of the class
              
        print ("temp2 = " + String(temp_list2.count))
              
        cell.day_label.text = day_list2[indexPath.row]
        cell.temp_label.text = temp_list2[indexPath.row]
        cell.weather_img.image = UIImage(named: icon_list2[indexPath.row])
    
        return cell
    }
}
