import UIKit

final class WeatherView: UIView, UIScrollViewDelegate {
    
    // MARK: - Var
    
    var weatherGlobalModel: WeatherGlobalModel?
    var constraint = NSLayoutConstraint()
    var collectionConstraint = NSLayoutConstraint()
    
    // MARK: - Let
    
    let loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        return loader
    }()
    
    let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: CollectionLayout.createLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.layer.cornerRadius = 15
        collectionView.alwaysBounceVertical = false
        collectionView.backgroundColor = .systemMint.withAlphaComponent(0.3)
        return collectionView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.layer.cornerRadius = 15
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.rowHeight = 70
        return tableView
    }()
    
    let scrollView: UIScrollView = {
        let scrollView = StyleSheet().addScrollView()
        return scrollView
    }()
    
    let containerView: UIView = {
        let containerView = StyleSheet().addWeekView()
        return containerView
    }()
    
    let cityLabel: UILabel = {
        let cityLabel = StyleSheet().addCityLabel()
        return cityLabel
    }()
    
    let weatherDescription: UILabel = {
        let weatherDescription = StyleSheet().addWeatherDescription()
        return weatherDescription
    }()
    
    let degrees: UILabel = {
        let degrees = StyleSheet().addDegrees()
        return degrees
    }()
    
    let day: UILabel = {
        let day = StyleSheet().addDay()
        return day
    }()
    
    var dayOfWeek: String = {
        let dayOfWeek = String()
        return dayOfWeek
    }()
    
    let maxMinDegrees: UILabel = {
        let maxMinDegrees = UILabel()
        maxMinDegrees.translatesAutoresizingMaskIntoConstraints = false
        maxMinDegrees.font = UIFont.boldSystemFont(ofSize: 15)
        maxMinDegrees.textColor = .systemBackground
        maxMinDegrees.textAlignment = .center
        return maxMinDegrees
    }()
    
    let cellId = "cellId"
    let tableCellId = "Cellid"
    
    let gradientLayer = CAGradientLayer()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        scrollView.delegate = self
        
        addLoader()
        setupConstraints()
        setUpConstrainsScrollView()
        scrollViewDidScroll(scrollView)
        
        collectionView.register(CustomCollectionCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: tableCellId)
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMove(toSuperview newSuperview: UIView?) {
        loader.startAnimating()
    }
    
    override func layoutSubviews() {
        addLayer()
    }
    
    // MARK: - Setup constraints
    
    func setupConstraints() {
        addSubview(cityLabel)
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            cityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            cityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100),
        ])
        addSubview(weatherDescription)
        NSLayoutConstraint.activate([
            weatherDescription.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            weatherDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100),
            weatherDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -100)
        ])
        addSubview(degrees)
        NSLayoutConstraint.activate([
            degrees.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor, constant: 50),
            degrees.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            degrees.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)
        ])
        
    }
    
    func setUpConstrainsScrollView() {
        
        addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: weatherDescription.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        scrollView.addSubview(containerView)
        constraint = containerView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor, constant: 225),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            constraint,
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        containerView.addSubview(day)
        NSLayoutConstraint.activate([
            day.topAnchor.constraint(equalTo: containerView.topAnchor),
            day.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 20)
        ])
        containerView.addSubview(maxMinDegrees)
        NSLayoutConstraint.activate([
            maxMinDegrees.topAnchor.constraint(equalTo: containerView.topAnchor),
            maxMinDegrees.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10)
        ])
        containerView.addSubview(collectionView)
        collectionConstraint = collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: day.bottomAnchor,constant: 5),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            collectionConstraint
        ])
        
        containerView.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -10),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    // MARK: - Scroll view did scroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
        }
        if (scrollView.contentOffset.y < 0){
            degrees.alpha = 0
            degrees.alpha = 1
            
        }
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            let percentage: CGFloat = (scrollView.contentOffset.y) / 75
            degrees.alpha = (percentage)
            degrees.alpha = (1 - percentage)
            
        }
    }
    
    // MARK: - Configure
    
    func configure(weatherGlobalModel: WeatherGlobalModel) {
        constraint.constant = CGFloat(weatherGlobalModel.weatherSortedModel.list.count * 70 + 142)
        collectionConstraint.constant = 95
        
        layoutIfNeeded()
        
        loader.stopAnimating()
        
        self.weatherGlobalModel = weatherGlobalModel
        
        tableView.reloadData()
        collectionView.reloadData()
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        day.text = dayOfTheWeekString.capitalized
        
        func isCurrentDay(date: Date) -> Bool {
            let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: date)
            let dateComponentsToday = Calendar.current.dateComponents([.day, .month, .year], from: Date())
            return dateComponents.day == dateComponentsToday.day && dateComponents.month == dateComponentsToday.month &&
            dateComponents.year == dateComponentsToday.year
        }
        
        guard let maxDegrees = weatherGlobalModel.weatherModel.list.filter({Calendar.current.isDateInToday($0.dtTxt)}).map( {$0.main.tempMax }).max() else { return }
        guard let minDegrees = weatherGlobalModel.weatherModel.list.filter({ isCurrentDay(date: $0.dtTxt) }).map({$0.main.tempMin }).min() else { return }
        maxMinDegrees.text = "\(doubleToInteger(data: maxDegrees))°  \(doubleToInteger(data: minDegrees))°"
        
        cityLabel.text = weatherGlobalModel.weatherModel.city.name
        
        guard let modelWeatherDescription = weatherGlobalModel.weatherModel.list.first?.weather.first?.weatherDescription else { return }
        
        weatherDescription.text = modelWeatherDescription.capitalized
        
        guard let modelDegrees = weatherGlobalModel.weatherModel.list.first?.main.temp else { return }
        degrees.text = "\(doubleToInteger(data: modelDegrees))°"
    }
    
    //MARK: - DoubleToInteger
    
    public func doubleToInteger(data: Double) -> Int {
        let doubleToString = "\(data)"
        let stringToInteger = (doubleToString as NSString).integerValue
        return stringToInteger
    }
    
    //MARK: - AddLoader
    
    func addLoader() {
        addSubview(loader)
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loader.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    //MARK: - AddLayer
    
    func addLayer() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            UIColor.systemMint.cgColor,
            UIColor.systemBlue.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
