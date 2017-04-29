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
    var fechedForecast : [DayForeCast]? = []
    var NumberOfRows = 10
    var DatesArray: [String] = []
    var HighArray: [String] = []
    var LowArray: [String] = []
    var foreCastsArray = [Forecast]()
    
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
            
        }
    }
    

    

    
    func getWeekForecats(){
       let url = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid=%201591691%20and%20u=%27c%27&format=json"
        var request = URLRequest(url:URL(string:url)!)
        

        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request){(data, response, error) in
            
            if error != nil {
                print(error as Any)
            } else {
                
                self.fechedForecast = [DayForeCast]()
                
                do {
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary {
                    
                        if let query = json!.value(forKey: "query") as? NSDictionary {
                            
                            if let results = query.value(forKey: "results") as? NSDictionary {
                                if let channel = results.value(forKey: "channel") as? NSDictionary {
                                    if let items = channel.value(forKey: "item") as? NSDictionary {
                                        if let foreCasts = items.value(forKey: "forecast") as? NSArray {
                                            
                                            for forecast in foreCasts {
                       
                                                if let forecastDict = forecast as? NSDictionary {
                                                    
                                                    let dateStr: String = {
                                                        if let date = forecastDict.value(forKey: "date") {
                                                            return date as! String
                                                        }
                                                        return "date"
                                                    }()
                                                    
                                                    let dayStr: String = {
                                                        if let day = forecastDict.value(forKey: "day") {
                                                            return day as! String
                                                        }
                                                        return "day"
                                                    }()
                                                    
                                                    let highStr: String = {
                                                        if let high = forecastDict.value(forKey: "high") {
                                                            return high as! String
                                                        }
                                                        return "high"
                                                    }()
                                                    
                                                    let lowStr: String = {
                                                        if let low = forecastDict.value(forKey: "low") {
                                                            return low as! String
                                                        }
                                                        return "low"
                                                    }()
                                                    
                                                    let textStr: String = {
                                                        if let text = forecastDict.value(forKey: "text") {
                                                            return text as! String
                                                        }
                                                        return "text"
                                                    }()
                                                    
                                                    let codeStr: String = {
                                                        if let code = forecastDict.value(forKey: "code") {
                                                            return code as! String
                                                        }
                                                        return "code"
                                                    }()
                                                    
                                                    self.foreCastsArray.append(Forecast(code: codeStr, date: dateStr, day: dayStr, low: lowStr, high: highStr, text: textStr))
                                                    
                                                    OperationQueue.main.addOperation({
                                                        self.forecastDisplay.reloadData()
                                                    })
                                                }
                                            }
                                        }
                                    }
                                    
                                }
                            
                            }
                        }
                    }
              
                    
                    
                    
//                    let json = try JSON(data:data!, options: JSONSerialization.ReadingOptions.mutableContainers)
//                    let jsonData = json["query", "results", "channel", "item", "forecast"]
                    
//                    self.NumberOfRows = jsonData.count
//                    print(self.numberOfRows)
//                    NSLog("\(jsonData)")
//
//                    var d = 0
//                    while d < self.NumberOfRows {
//                        let date = json["query", "results", "channel", "item", "forecast"][(d)]["date"].string!
//                        let high = json["query", "results", "channel", "item", "forecast"][(d)]["high"].string!
//                        let low = json["query", "results", "channel", "item", "forecast"][(d)]["high"].string!
//                        self.DatesArray.append(date)
//                        self.HighArray.append(high)
//                        self.LowArray.append(low)
//                        d += 1
//                    }


                    
                    print(self.DatesArray)
                    
                } catch let error{
                    print(error)
                }
            }
        
        }
        task.resume()
    }
    
    func numberOfRows(in tableView:NSTableView) -> Int{
        
        return foreCastsArray.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {

        if foreCastsArray.count != 0 {
            
            if tableColumn?.identifier == "date" {
                let cell = tableView.make(withIdentifier: "dateCell", owner: self) as? NSTableCellView
                cell?.textField?.stringValue = foreCastsArray[row].date
                
                return cell
            }
            if tableColumn?.identifier == "image" {
                let cell = tableView.make(withIdentifier: "imageCell", owner: self) as? NSTableCellView
                cell?.textField?.stringValue = foreCastsArray[row].text
                
                return cell
            }
            if tableColumn?.identifier == "low" {
                let cell = tableView.make(withIdentifier: "lowCell", owner: self) as? NSTableCellView
                cell?.textField?.stringValue = foreCastsArray[row].low + "°"
                
                return cell
            }
            if tableColumn?.identifier == "high" {
                let cell = tableView.make(withIdentifier: "lowCell", owner: self) as? NSTableCellView
                cell?.textField?.stringValue = foreCastsArray[row].high + "°"
                
                return cell
            }

        }
        
    
        return nil
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
