import Foundation

enum WeatherState: String {
    case snow = "Snow"
    case sleet = "Sleet"
    case hail = "Hail"
    case thunderstorm = "Thunderstorm"
    case heavyRain = "Heavy Rain"
    case lightRain = "Light Rain"
    case showers = "Showers"
    case heavyCloud = "Heavy Cloud"
    case lightCloud = "Light Cloud"
    case clear = "clear"
    
    var abbreviation: String {
        switch self {
            
        case .snow:
            return "sn"
        case .sleet:
            return "sl"
        case .hail:
            return "h"
        case .thunderstorm:
            return "t"
        case .heavyRain:
            return "hr"
        case .lightRain:
            return "lr"
        case .showers:
            return "s"
        case .heavyCloud:
            return "hc"
        case .lightCloud:
            return "lc"
        case .clear:
            return "c"
        }
    }
}
