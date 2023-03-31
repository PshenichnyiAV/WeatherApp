import UIKit

class TableViewCell: UITableViewCell {
    
    // MARK: -  Internal let
    
    let weekDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    let weatherConditionIcon: UIImageView = {
        let weatherConditionIcon = UIImageView()
        weatherConditionIcon.translatesAutoresizingMaskIntoConstraints = false
        return weatherConditionIcon
    }()
    
    let minTemperature: UILabel = {
        let minTemperature = UILabel()
        minTemperature.translatesAutoresizingMaskIntoConstraints = false
        minTemperature.textAlignment = .center
        return minTemperature
    }()
    
    let maxTemperature: UILabel = {
        let maxTemperature = UILabel()
        maxTemperature.translatesAutoresizingMaskIntoConstraints = false
        maxTemperature.textAlignment = .center
        return maxTemperature
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Internal methods
    
    func configure(listSortedModel: ListSortedModel?) {
        if let allTime = listSortedModel?.dtTxt {
            weekDayLabel.text = DatesFormatter.dateFormater(date: allTime, format: "EEEE d")
        }
        if let nameImage = listSortedModel?.weather.last?.icon {
            weatherConditionIcon.image = UIImage(named: nameImage)
        }
        if let minDegreesLabel = listSortedModel?.main.tempMin {
            minTemperature.text = "\(Int(minDegreesLabel))"
        }
        if let maxDegreesLabel = listSortedModel?.main.tempMax {
            maxTemperature.text = "\(Int(maxDegreesLabel))"
        }
    }
    
    // MARK: - Internal methods
    
    func addLabels() {
        addSubview(maxTemperature)
        NSLayoutConstraint.activate([
            maxTemperature.topAnchor.constraint(equalTo: topAnchor),
            maxTemperature.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -5),
            maxTemperature.heightAnchor.constraint(equalTo: heightAnchor),
            maxTemperature.bottomAnchor.constraint(equalTo: bottomAnchor),
            maxTemperature.widthAnchor.constraint(equalToConstant: 30)
        ])
        addSubview(minTemperature)
        NSLayoutConstraint.activate([
            minTemperature.topAnchor.constraint(equalTo: topAnchor),
            minTemperature.trailingAnchor.constraint(equalTo: maxTemperature.leadingAnchor,constant: -5),
            minTemperature.bottomAnchor.constraint(equalTo: bottomAnchor),
            minTemperature.heightAnchor.constraint(equalTo: heightAnchor),
            minTemperature.widthAnchor.constraint(equalToConstant: 30)
        ])
        addSubview(weatherConditionIcon)
        NSLayoutConstraint.activate([
            weatherConditionIcon.topAnchor.constraint(equalTo: topAnchor),
            weatherConditionIcon.trailingAnchor.constraint(equalTo: minTemperature.leadingAnchor,constant: -30),
            weatherConditionIcon.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherConditionIcon.heightAnchor.constraint(equalTo: heightAnchor),
            weatherConditionIcon.widthAnchor.constraint(equalToConstant: 75)
        ])
        addSubview(weekDayLabel)
        NSLayoutConstraint.activate([
            weekDayLabel.topAnchor.constraint(equalTo: topAnchor),
            weekDayLabel.trailingAnchor.constraint(equalTo: weatherConditionIcon.leadingAnchor,constant: -35),
            weekDayLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            weekDayLabel.heightAnchor.constraint(equalTo: heightAnchor),
        ])
    }
}
