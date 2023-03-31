import Foundation

// MARK: - Weather

struct WeatherResponseModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [ListResponseModel]
    let city: CityResponseModel
}

// MARK: - City

struct CityResponseModel: Codable {
    let id: Int
    let name: String
    let coord: CoordResponseModel
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - Coord

struct CoordResponseModel: Codable {
    let lat, lon: Double
}

// MARK: - List

struct ListResponseModel: Codable {
    let dt: Int
    let main: MainResponseModel
    let weather: [WeatherElementResponseModel]
    let visibility: Int
    let pop: Double
    let dtTxt: Date

    enum CodingKeys: String, CodingKey {
        case dt, main, weather,visibility, pop
        case dtTxt = "dt_txt"
    }
}

struct MainResponseModel: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct WeatherElementResponseModel: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon = "icon"
    }
}
