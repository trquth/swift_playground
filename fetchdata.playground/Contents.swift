import Foundation

class Main : Decodable {
    let temp : Double
}

class Weather : Decodable {
    let main : String
    let description : String
}

class WeatherData : Decodable {
    let name : String
    let main : Main
    let weather : [Weather]
}

struct FetchingWeatherData {
    let hostUrl =  "http://openweathermap.org/data/2.5/weather?appid=439d4b804bc8187953eb36d2a8c26a02"
    
    func fetchData(currentCity: String)  {
        let url  = "\(hostUrl)&q=\(currentCity)"
        handler(urlFull: url)
    }
    
    func handler(urlFull : String)  {
        if let url = URL(string: urlFull){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url, completionHandler: {(data , urlResponse, error) in
                if error != nil {
                    print(error)
                    return
                }
                
                if let receivedData = data {
                    parseData(data: receivedData)
                }
            })
            task.resume();
        }
    }
    
    func parseData(data: Data)  {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            print(decodedData.weather[0].main)
        }catch{
            print(error)
        }
    }
}


let obj = FetchingWeatherData()
obj.fetchData(currentCity: "London")
