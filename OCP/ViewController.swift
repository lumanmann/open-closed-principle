//
//  ViewController.swift
//  OCP
//
//  Created by WY NG on 10/11/2019.
//  Copyright © 2019 natalie. All rights reserved.
//

import UIKit

enum ViewControllerState {
    case normal([UBikeStation])
    case error(Error)
    case empty
    case loading
}

final class ViewController: UIViewController {
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var ubikeStationTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var state: ViewControllerState = .empty {
        didSet {
            switch state {
            case .normal(_):
                stateLabel.text = ""
            case .error(_):
                stateLabel.text = "ERROR!!"
            case .empty:
                stateLabel.text = "EMPTY"
            case .loading:
                stateLabel.text = "LOADING..."
                
            }
            self.ubikeStationTableView.reloadData()
        }
    }
    
    private var ubikeStations: [UBikeStation] {
        switch state {
        case .normal(let items):
            return items
        case .error(_):
            return []
        case .empty:
            return []
        case .loading:
            return []
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        loadStations()
    }
    
    
    private func loadStations() {
        state = .loading
        APIService.getStationsList { [weak self] (error, result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                if let error = error {
                    self.state = .error(error)
                    return
                }
                
                guard let result = result else {
                    self.state = .empty
                    return
                }
                
                let stations = Array(result.retVal.values)
                
                guard !stations.isEmpty else {
                    self.state = .empty
                    return
                }
                
                self.state = .normal(stations)
            }
            
        }
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(ubikeStationTableView)
        view.addSubview(stateLabel)
        
        
        NSLayoutConstraint.activate([
            ubikeStationTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            ubikeStationTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            ubikeStationTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            ubikeStationTableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            ])
        
        NSLayoutConstraint.activate([
            stateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ubikeStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        let item = ubikeStations[indexPath.row]
        cell.textLabel?.text = item.sna
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.detailTextLabel?.text = item.ar
        cell.detailTextLabel?.numberOfLines = 0
        cell.selectionStyle = .none
        
        
        return cell
    }
}


