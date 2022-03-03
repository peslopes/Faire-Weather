import Foundation

struct LocationWeather: Decodable {
    let consolidatedWeather: [ConsolidatedWeather]
    let title: String
    
    enum CodingKeys: String, CodingKey {
        case consolidatedWeather = "consolidated_weather"
        case title
    }
}

struct ConsolidatedWeather: Decodable {
    let minTemp: Double
    let maxTemp: Double
    let theTemp: Double
    let weatherStateName: String
    
    var weatherState: WeatherState? {
        return WeatherState(rawValue: weatherStateName)
    }
    
    enum CodingKeys: String, CodingKey {
        case weatherStateName = "weather_state_name"
        case minTemp = "min_temp"
        case maxTemp = "max_temp"
        case theTemp = "the_temp"
    }
}
