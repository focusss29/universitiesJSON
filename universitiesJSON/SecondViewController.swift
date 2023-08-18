//
//  SecondViewController.swift
//  universitiesJSON
//
//  Created by Ilya Pogozhev on 18.08.2023.
//

import UIKit
import SnapKit
import Alamofire

class SecondViewController: UIViewController {
    
    let tableView = UITableView(frame: .zero, style: .plain)
    let cellID = "UniverID"
    
    var universitiesNamed: [UniversityDatum] = []
    var country: Datum?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        makeConstraints()
        navigationItem.title = country?.country
        loadingData()
    }
}
private extension SecondViewController {
    func setupTable() {
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
    func loadingData() {
        let url = "http://universities.hipolabs.com/search?country=\(country?.country)"
        AF.request(url).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode([UniversityDatum].self, from: data)
                    self.universitiesNamed = response
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
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        universitiesNamed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let universities = universitiesNamed[indexPath.row]
        cell.textLabel?.text = "\(universities.name)"
        return cell
    }
}
