import UIKit

class CustomCollectionCell: UICollectionViewCell {
    
    //MARK: - Internal var
    
    var degrees: UILabel = {
        let degrees = StyleSheet().addDegrees()
        degrees.translatesAutoresizingMaskIntoConstraints = false
        degrees.font = UIFont.boldSystemFont(ofSize: 20)
        degrees.textColor = .label
        return degrees
    }()
    
    var time: UILabel = {
        let time = UILabel()
        time.translatesAutoresizingMaskIntoConstraints = false
        time.textAlignment = .center
        time.textColor = .label
        return time
    }()
    
    var weatherImage: UIImageView = {
        let weatherImage = UIImageView()
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        return weatherImage
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal methods
    
    func configure(listModel: ListModel?) {
        if let degree = listModel?.main.temp {
            degrees.text = "\(Int(degree))°"
        }
        if let date = listModel?.dtTxt {
            time.text = DatesFormatter.dateFormater(date: date, format: "HH")
        }
        if let imageName = listModel?.weather.last?.icon {
            weatherImage.image = UIImage(named: imageName)
        }
    }
    
    // MARK: - Private methods
    
    private func addLabels() {
        addSubview(degrees)
        NSLayoutConstraint.activate([
            degrees.topAnchor.constraint(equalTo: topAnchor,constant: 5),
            degrees.leadingAnchor.constraint(equalTo: leadingAnchor),
            degrees.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        addSubview(time)
        NSLayoutConstraint.activate([
            time.topAnchor.constraint(equalTo: degrees.bottomAnchor, constant: 5),
            time.leadingAnchor.constraint(equalTo: leadingAnchor),
            time.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        addSubview(weatherImage)
        NSLayoutConstraint.activate([
            weatherImage.topAnchor.constraint(equalTo: time.bottomAnchor),
            weatherImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 15),
            weatherImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            weatherImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
