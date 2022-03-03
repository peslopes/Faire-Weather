import Foundation

enum APIEndpoint {
    case searchByLattLong(latt: Double, long: Double)
    case searchByQuery(query: String)
    case searchByWoeid(woeid: Int)
    case getIcon(abb: String)
    
    var url: String {
        switch self {
        case .searchByLattLong(latt: let latt, long: let long):
            return "/api/location/search/?lattlong=\(latt),\(long)"
        case .searchByQuery(query: let query):
            let queryToSearch = query.replacingOccurrences(of: " ", with: "%20")
            return "/api/location/search/?query=\(queryToSearch)"
        case .searchByWoeid(woeid: let woeid):
            return "/api/location/\(woeid)/"
        case .getIcon(abb: let abb):
            return "/static/img/weather/ico/\(abb).ico"
        }
    }
    
    var shouldReturnList: Bool {
        switch self {
        case .searchByLattLong:
            return true
        case .searchByQuery:
            return true
        case .searchByWoeid:
            return false
        case .getIcon:
            return false
        }
    }
}
