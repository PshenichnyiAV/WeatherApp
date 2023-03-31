import UIKit

struct StyleSheet {
    
    //MARK: - Internal methods
    
    func addScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }
    
    func addCityLabel() -> UILabel {
        let cityLabel = UILabel()
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.font = UIFont.boldSystemFont(ofSize: 30)
        cityLabel.textColor = .systemBackground
        cityLabel.textAlignment = .center
        return cityLabel
    }
    
    func addWeekView() -> UIView {
        let weekView = UIView()
        weekView.translatesAutoresizingMaskIntoConstraints = false
        weekView.backgroundColor = .clear
        weekView.layer.cornerRadius = 15
        return weekView
    }
    
    func addWeatherDescription() -> UILabel {
        let weatherDescription = UILabel()
        weatherDescription.translatesAutoresizingMaskIntoConstraints = false
        weatherDescription.font = UIFont.boldSystemFont(ofSize: 14)
        weatherDescription.textColor = .systemBackground
        weatherDescription.textAlignment = .center
        return weatherDescription
    }
    
    func addDegrees() -> UILabel {
        let degrees = UILabel()
        degrees.translatesAutoresizingMaskIntoConstraints = false
        degrees.font = UIFont.boldSystemFont(ofSize: 100)
        degrees.textColor = .systemBackground
        degrees.textAlignment = .center
        degrees.numberOfLines = 0
        return degrees
    }
    
    func addDay() -> UILabel {
        let day = UILabel()
        day.translatesAutoresizingMaskIntoConstraints = false
        day.font = UIFont.boldSystemFont(ofSize: 15)
        day.textColor = .systemBackground
        day.textAlignment = .center
        return day
    }
}
