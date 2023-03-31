import Foundation

// MARK: - WeatherSortedModel

struct NetworkingMapper {
    static func map(response: WeatherResponseModel) -> WeatherGlobalModel {
        WeatherGlobalModel(response: response)
    }
}

//MARK: - WeatherGlobalModel

extension WeatherGlobalModel {
    init(response: WeatherResponseModel) {
        self.init(weatherModel: WeatherModel(response: response), weatherSortedModel: WeatherSortedModel(response: response))
    }
}

//MARK: - WeatherSortedModel

extension WeatherSortedModel {
    init(response: WeatherResponseModel) {
        let sortedList = response.list.reduce(into: [ListResponseModel]()) { collection, item in
            guard !collection.contains(where: { DatesFormatter.compare(item.dtTxt, equalTo: $0.dtTxt, by: [ .day, .month]) }) else { return }
            collection.append(item)
        }
        self.init(
            list: sortedList.map { ListSortedModel(response: $0) },
            city: CitySortedModel(response: response.city)
        )
    }
}

//MARK: - ListSortedModel

extension ListSortedModel {
    init(response: ListResponseModel) {
        self.init(main: MainSortedModel(response: response.main),
                  weather: response.weather.map { WeatherElementSortedModel(response: $0)} ,
                  visibility: response.visibility,
                  dtTxt: response.dtTxt)
    }
}

//MARK: - CitySortedModel

extension CitySortedModel {
    init(response: CityResponseModel) {
        self.init(name: response.name,
                  sunrise: response.sunrise,
                  sunset: response.sunset)
    }
}

//MARK: - MainSortedModel

extension MainSortedModel {
    init(response: MainResponseModel) {
        
        self.init(temp: response.temp,
                  feelsLike: response.feelsLike,
                  tempMin: response.tempMin,
                  tempMax: response.tempMax,
                  pressure: response.pressure,
                  seaLevel: response.seaLevel,
                  grndLevel: response.grndLevel)
    }
}

//MARK: - WeatherElementSortedModel

extension WeatherElementSortedModel {
    init(response: WeatherElementResponseModel) {
        self.init(weatherDescription: response.weatherDescription,
                  icon: response.icon)
    }
}

// MARK: - WeatherModel

extension WeatherModel {
    init(response: WeatherResponseModel) {
        let sortedList = response.list.reduce(into: [ListResponseModel]()) { collection, item in
            guard !collection.contains(where: { DatesFormatter.compare(item.dtTxt, equalTo: $0.dtTxt, by: [ .hour]) }) else { return }
            collection.append(item)
        }
        self.init(
            list: sortedList.map { ListModel(response: $0) },
            city: CityModel(response: response.city)
        )
    }
}

//MARK: - ListModel

extension ListModel {
    init(response: ListResponseModel) {
        self.init(main: MainModel(response: response.main),
                  weather: response.weather.map { WeatherElementModel(response: $0)} ,
                  visibility: response.visibility,
                  dtTxt: response.dtTxt)
    }
}

//MARK: - CityModel

extension CityModel {
    init(response: CityResponseModel) {
        self.init(name: response.name,
                  sunrise: response.sunrise,
                  sunset: response.sunset)
    }
}

//MARK: - MainModel

extension MainModel {
    init(response: MainResponseModel) {
        
        self.init(temp: response.temp,
                  feelsLike: response.feelsLike,
                  tempMin: response.tempMin,
                  tempMax: response.tempMax,
                  pressure: response.pressure,
                  seaLevel: response.seaLevel,
                  grndLevel: response.grndLevel)
    }
}

//MARK: - WeatherElementModel

extension WeatherElementModel {
    init(response: WeatherElementResponseModel) {
        self.init(weatherDescription: response.weatherDescription,
                  icon: response.icon)
    }
}
