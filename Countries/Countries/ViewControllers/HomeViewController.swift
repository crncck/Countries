//
//  ViewController.swift
//  Countries
//
//  Created by Ceren Çiçek on 6.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!

    var chosenCountryCode = ""

    var listOfCountries = [Country]() {
            didSet {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
    }

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "cell")

        fetchCountries()

    }

    // MARK: - API

    func fetchCountries() {

        let countriesRequest = CountryService()
        countriesRequest.getCountries { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countries):
                self?.listOfCountries = countries
            }
        }

    }

    // MARK: - Actions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController {
            detailsViewController.chosenCountryCode = chosenCountryCode
        }
    }


    // MARK: - Helpers

    func updateUI() {
        self.navigationItem.title = "Countries"
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
    }

}


// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfCountries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryCell {

            let country = listOfCountries[indexPath.row]
            cell.country = country
            return cell
        }

        return UITableViewCell()
    }

}


// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCountryCode = listOfCountries[indexPath.row].code
        performSegue(withIdentifier: "goDetails", sender: self)
    }

}

