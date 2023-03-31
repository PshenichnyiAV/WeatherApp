import Foundation

protocol NetworkServiceProtocol {
    func load(lat: CGFloat, lon: CGFloat) async throws -> WeatherGlobalModel
}

final class NetworkService: NetworkServiceProtocol {
    
    // MARK: - Internal methods
    
    func load(lat: CGFloat, lon: CGFloat) async throws -> WeatherGlobalModel  {
        guard let url = makeUrl(lat: lat, lon: lon) else { throw URLError(.badURL) }
        let jsonDecoder = JSONDecoder()
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "YYYY-MM-dd HH:mm:ss"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormater)
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let weatherResponseModel = try jsonDecoder.decode(WeatherResponseModel.self, from: data)
        let result = NetworkingMapper.map(response: weatherResponseModel)
        return result
    }
    
    // MARK: - Private methods
    
    private func makeUrl(lat: CGFloat, lon: CGFloat) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/forecast"
        components.queryItems = [
            URLQueryItem(name: "lat", value: lat.description),
            URLQueryItem(name: "lon", value: lon.description),
            // URLQueryItem(name: "cnt", value: cnt.description),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: ApiKeys.weatherKey)
        ]
        return components.url
    }
    
}

