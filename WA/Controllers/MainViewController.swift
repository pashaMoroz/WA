//
//  ViewController.swift
//  WA
//
//  Created by Pavel Moroz on 22.10.2020.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {

    private var timer = Timer()

    private let tableView = UITableView()

    private let locationManager = CLLocationManager()

    private let networkDataFetcher = HTTPNetworkingDataFetcher()

    //Property for Activity indicator
    private let loadingView = UIView()
    private let spinner = UIActivityIndicatorView()
    private let loadingLabel = UILabel()

    private var dataIsReady: Bool = false

    private var offerModel: CurrentCityWeatherListModel! {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    //MARK: viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        self.setupNavigationBar()
        self.setupTableView()

        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        setupActivityIndicator()
    }

    //MARK: setupNavigationBar

    private func setupNavigationBar() {
        self.navigationItem.title = "Поиск Города"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        let searchController = UISearchController(searchResultsController: nil)

        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }

    //MARK: setupTableView

    private func setupTableView() {

        view.addSubview(tableView)

        self.tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}


//MARK: CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {

    private func setUpLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

//MARK: UISearchResultsUpdating

extension MainViewController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {

        addLoadingScreen()

        let city = searchController.searchBar.text!
        timer.invalidate()
        if city != "" {
            timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in

                self.networkDataFetcher.fetchWeatherFrom(searchTerm: city) { (result) in
                    switch result {

                    case .success(let data):
                        print(data)
                        self.offerModel = data
                        self.dataIsReady = true
                    case .failure:
                        self.showAlert(with: "Поиск не дал результатов", and: "Попробуйте ввести название вашего города правильно.")
                    }
                    self.removeLoadingScreen()
                }
            })
        } else {
            self.removeLoadingScreen()
        }
    }
}

//MARK: - UITableViewDataSource UITableViewDelegate Methods

extension MainViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if dataIsReady {
            return 1
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseIdentifier) as! CustomTableViewCell

        cell.configureCell(model: offerModel, indexPathRow: indexPath.row)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let vc = DetailCityViewController()

        guard let cityName = offerModel.city?.name else { return }
        guard let temperature = offerModel.list?[0].main?.temp else { return }
        vc.temperatureLabel.text = String("\(Int(temperature-273.5))°")
        vc.cityNameLabel.text = cityName
        vc.noteLabel.text = WeatherSettings.notesForCurrentCity

        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Setup UIActivityIndicator

extension MainViewController {

    private func setupActivityIndicator() {

        loadingView.frame = CGRect(x: tableView.center.x, y: tableView.center.y, width: 120, height: 30)

        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.frame = CGRect(x: tableView.center.x, y: tableView.center.y, width: 140, height: 30)

        // Sets spinner
        spinner.style = .medium
        spinner.frame = CGRect(x: tableView.center.x, y: tableView.center.y, width: 30, height: 30)

        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)

        tableView.tableFooterView?.addSubview(loadingView)
    }

    private func addLoadingScreen() {

        spinner.startAnimating()
        loadingLabel.text = "Loading..."
        spinner.isHidden = false
        loadingLabel.isHidden = false
    }

    private func removeLoadingScreen() {

        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }
}

