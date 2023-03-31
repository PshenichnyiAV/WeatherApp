import Foundation

// MARK: - WeatherModel

struct WeatherModel {
    let list: [ListModel]
    let city: CityModel
}

// MARK: - ArrList

struct ListModel {
    let main: MainModel
    let weather: [WeatherElementModel]
    let visibility: Int
    let dtTxt: Date
}

// MARK: - CityModel

struct CityModel {
    let name: String
    let sunrise, sunset: Int
}

// MARK: - WeatherElementArray

struct WeatherElementModel {
    let weatherDescription, icon: String
}

// MARK: - MainModel

struct MainModel {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel: Int
}






