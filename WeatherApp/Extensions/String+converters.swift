import Foundation

extension String {
    func convertToCoordinate() -> (latt: Double, long: Double)? {
        var components = self.components(separatedBy: ",")
        
        guard components.count == 2 else { return nil }
        
        components = components.map {
            $0.replacingOccurrences(of: " ", with: "")
        }
        
        guard let latt = Double(components[0]), let long = Double(components[1]) else { return nil }
        
        return (latt: latt, long: long)
    }
}
