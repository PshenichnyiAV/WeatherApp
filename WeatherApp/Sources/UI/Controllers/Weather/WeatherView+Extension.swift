import UIKit

// MARK: - UITableViewDelegate, UITableViewDataSource

extension WeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherGlobalModel?.weatherSortedModel.list.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "  Forecust for 5 days"
        label.textColor = .white
        label.backgroundColor = UIColor.systemMint.withAlphaComponent(0.5)
        label.alpha = 1
        return label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cellid") as? TableViewCell else { return UITableViewCell() }
        let sortedModel = weatherGlobalModel?.weatherSortedModel.list[indexPath.item]
        cell.configure(listSortedModel: sortedModel)
        cell.prepareForReuse()
        cell.backgroundColor = .systemMint.withAlphaComponent(0.3)
        cell.selectionStyle = .none
        return cell
    }
    
    func doubleToInteger(data: [Double]) -> [Int] {
        let doubleToString = data
        var arrInt: [Int] = []
        for i in doubleToString {
            let int = doubleToInteger(data: i)
            arrInt.append(int)
        }
        return arrInt
    }
    
    func dateFormater(datef: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d"
        let allTimeStr = dateFormatter.string(from: datef)
        return allTimeStr
    }
    
    func setImage(name: String) -> UIImage {
        let name = name
        var image = UIImage()
        image = UIImage(named: name) ?? UIImage(systemName: "scribble")!
        return image
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension WeatherView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  weatherGlobalModel?.weatherModel.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? CustomCollectionCell else { return UICollectionViewCell() }
        
        let model = weatherGlobalModel?.weatherModel.list[indexPath.item]
        cell.configure(listModel: model)
        return cell
    }
}
