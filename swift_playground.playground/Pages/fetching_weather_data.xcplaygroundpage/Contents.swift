import Foundation

//For parse JSON
class Main : Codable {
    let temp : Double
}

class Weather : Codable {
    let id  : Int
    let main : String
    let description : String
}

class WeatherData : Codable {
    let name : String
    let main : Main
    let weather : [Weather]
}

//View Model in MVC
//class need initialize data for properties
//struct did not do
struct WeatherModel  {
    let conditionId : Int
    let temperature : Double
    let cityName : String
    
    var temperatureString : String {
        return String(format: "%0.1f", temperature)
    }
    
    var conditionName : String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300 ... 321 :
            return "cloud.drizzle"
        case 500...531 :
            return "cloud.rain"
        case 600...622 :
            return "cloud.snow"
        case 701...781 :
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
            
        }
    }
}

protocol FetchingWeatherDataDelegate {
    func fetchingDataSuccess(_ responseData : WeatherModel)
    func  fetchingDataFailure (error : Error)
}

struct FetchingWeatherData {
    let hostUrl =  "http://openweathermap.org/data/2.5/weather?appid=439d4b804bc8187953eb36d2a8c26a02"
    
    var delegate : FetchingWeatherDataDelegate?
    
    func fetchData(currentCity: String)  {
        let url  = "\(hostUrl)&q=\(currentCity)"
        handler(urlFull: url)
    }
    
    func handler(urlFull : String)  {
        if let url = URL(string: urlFull){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){(data , urlResponse, error) in
                if error != nil {
                    delegate?.fetchingDataFailure(error: error!)
                    return
                }
                
                if let receivedData = data {
                    if let weatherData =  parseData(data: receivedData){
                        delegate?.fetchingDataSuccess(weatherData )
                    }
                }
            }
            task.resume();
        }
    }
    
    func parseData(data: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: data)
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(conditionId: id, temperature: temp, cityName: name)
            return weather
        }catch{
            delegate?.fetchingDataFailure(error: error )
            return nil
        }
    }

}


class WeatherVC{
    
    func call()  {
        var obj = FetchingWeatherData()
        obj.delegate = self;
        obj.fetchData(currentCity: "Canada")
    }
    
    
  
}

extension WeatherVC :FetchingWeatherDataDelegate {
    //With extension, we can break a large file to small file
    func fetchingDataSuccess(_ responseData: WeatherModel) {
        print("---------Trigger fetchingDataSuccess method--------------")
        print("response data ------->",responseData)
        DispatchQueue.main.async {
            //Have to call this method to update UI in main thread
            print("main thread", responseData.conditionName)
        }
    }
    
    func fetchingDataFailure(error: Error) {
        print("---------Trigger fetchingDataFailure method--------------")
        print("error------->",error)
    }
}


let weatherVC = WeatherVC()
weatherVC.call()
