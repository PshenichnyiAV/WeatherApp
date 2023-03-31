
import Foundation

// MARK: - WeatherSortedModel

struct WeatherSortedModel {
    let list: [ListSortedModel]
    let city: CitySortedModel
}

// MARK: - ListSortedModel

struct ListSortedModel {
    let main: MainSortedModel
    let weather: [WeatherElementSortedModel]
    let visibility: Int
    let dtTxt: Date
}

// MARK: - CitySortedModel

struct CitySortedModel {
    let name: String
    let sunrise, sunset: Int
}

// MARK: - WeatherElementSortedModel

struct WeatherElementSortedModel {
    let weatherDescription, icon: String
}

// MARK: - MainSortedModel

struct MainSortedModel {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel: Int
}
