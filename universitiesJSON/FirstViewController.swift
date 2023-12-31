//
//  ViewController.swift
//  universitiesJSON
//
//  Created by Ilya Pogozhev on 18.08.2023.
//

import UIKit
import SnapKit
import Alamofire

class FirstViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    let cellID: String = "CellCountry"
    var countries: [Datum] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemMint
        
        setupScene()
        makeConstraints()
        dataLoading()
        
    }
}
private extension FirstViewController {
    func setupScene() {
        view.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
        tableView.delegate = self
    }
    func makeConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func dataLoading() {
        AF.request("https://api.first.org/data/v1/countries").responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(CountryData.self, from: data)
                    self.countries = Array(response.data.values)
                    self.tableView.reloadData()
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
extension FirstViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
//        let filtedCountry = countries.sorted {$0.country < $1.country }
        let country = countries[indexPath.row].country
        cell.textLabel?.text = "\(country)"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = countries[indexPath.row]
        let secondVC = SecondViewController()
        secondVC.country = country
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    
}

