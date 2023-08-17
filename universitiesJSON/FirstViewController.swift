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
    
    var countries: [Datum] = []
    
    let cellID: String = "CellCountry"
    
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
            case .success(let jsonData):
                let decoder = JSONDecoder()
                do {
                    let countryResponse = try decoder.decode(CountryResponse.self, from: jsonData)
                    self.countries = Array(countryResponse.data.values)
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
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.country
        return cell
    }
    
    
}

