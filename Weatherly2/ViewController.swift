//
//  ViewController.swift
//  Weatherly
//
//  Created by MIles Work on 2017/04/23.
//  Copyright © 2017 MIles Work. All rights reserved.
//

import Cocoa


class ViewController: NSViewController,WeatherApiDelegate, NSTableViewDataSource, NSTableViewDelegate {

    @IBOutlet weak var closeButton: NSButton!
    @IBOutlet weak var cityName: NSTextField!
    @IBOutlet weak var date: NSTextField!
    @IBOutlet weak var tempDisplay: NSTextField!
    @IBOutlet weak var forecastDisplay: NSTableView!
    @IBOutlet weak var mainImage: NSImageView!
    var weather: WeatherApi!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weather = WeatherApi(delegate: self)
        let pinkrose = NSColor(red: 0/255.0, green: 48.0/255.0, blue: 86.0/255.0, alpha: 1.0)
        self.view.layer?.backgroundColor = pinkrose.cgColor

        closeButton.image = NSImage(named: "close")
        cityName.stringValue = ""
        cityName.textColor = NSColor.white
        date.stringValue = ""
        date.textColor = NSColor.white
        tempDisplay.stringValue = ""
        let url = URL(string:"https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid=%201591691%20and%20u=%27c%27&format=json")
        weather.getWeather(url: url!)
    }


    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func didNotGetWeather(error: NSError){
        DispatchQueue.main.async() {
            print(error)
        }
    }

    func didGetWeather(weather: Weather){
        print("fetch weather")
        DispatchQueue.main.async() {
            self.cityName.stringValue = weather.city
            self.date.stringValue = weather.currentDate
            self.tempDisplay.stringValue = weather.tempHigh + "°"
            self.mainImage.image = NSImage(named:"sunny")
            self.getWeekForecats()
            self.forecastDisplay.reloadData()
        }
    }
    
//    func numberOfRows(in tableView:NSTableView) -> Int{
//    
//        return nil
//    }
    
//    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        
////        let cell = tableView.make(withIdentifier: "cell1", owner: self) as? NSTableCellView
////        let individualRow = fechedForecast?[row]
////        cell?.textField?.stringValue = (individualRow?.day!)!
//
//        return nil
//    }
    
    func getWeekForecats(){
//       let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid=%201591691%20and%20u=%27c%27&format=json"
//        var request = URLRequest(url:URL(string:url)!)
//        request.httpMethod = "GET"
//        
//        let configuration = URLSessionConfiguration.default
//        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
//        
//        let task = session.dataTask(with: request){(data, response, error) in
//            
//            if error != nil {
//                print(error as Any)
//            } else {
//                
//                self.fechedForecast = [DayForeCast]()
//                
//                do {
//                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: AnyObject]
//                    
//                    let level1 = json["query"] as! NSDictionary
//                    let level2 = level1["results"] as! NSDictionary
//                    let level3 = level2["channel"] as! NSDictionary
//                    let level4 = level3["item"] as! NSArray
//                
//                    for var t in level4{
//                        print(t)
//                    }
//                    
//                } catch let error{
//                    print(error)
//                }
//            }
//        
//        }
//        task.resume()
    }
    
}


class DayTemperature {
    var code : String;
    var date : String;
    var day : String;
    var low : String;
    var high : String;
    var text : String;
    
    init(
        code : String,
        date : String,
        day : String,
        low : String,
        high : String,
        text : String
        ) {
        self.code = code;
        self.date = date;
        self.day = day;
        self.low = low;
        self.high = high;
        self.text = text;
    }
}
