import XCTest
@testable import WeatherApp

class APIControllerTests: XCTestCase {

    func test_fetchLocationWeather_withSuccess() {
        let expectation = XCTestExpectation(description: #function)
        let apiController = APIController(requester: FakeRequester())
        var locationWeather: LocationWeather? = nil
        
        apiController.fetch(endpoint: .searchByWoeid(woeid: 4118)) { (result: Result<LocationWeather, RequesterError>) in
            switch result {
            case .success(let object):
                locationWeather = object
                expectation.fulfill()
            case .failure(let error):
                XCTFail(error.localizedDescription)
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(locationWeather)
    }
}

final class FakeRequester: RequesterContract {
    func request(urlRequest: URLRequest, completion: @escaping (Result<Data, RequesterError>) -> Void) {
        
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "MockLocationWeather", withExtension: "json") else {
            completion(.failure(.invalidURL))
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            completion(.success(jsonData))
        }
        catch {
            completion(.failure(.requestError(localizedDescription: error.localizedDescription)))
        }
    }
}
