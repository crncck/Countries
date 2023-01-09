//
//  ViewController.swift
//  Countries
//
//  Created by Ceren Çiçek on 6.01.2023.
//

import UIKit

class HomeViewController: UIViewController {

    public var chosenCountryCode = ""

    // MARK: - Properties

    @IBOutlet private weak var tableView: UITableView!

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "cell")          // register country cell nib

        fetchCountries()

    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - API

    // creates an api request and gets the results as a country objects
    private func fetchCountries() {

        let countriesRequest = CountryService()
        countriesRequest.getCountries { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countries):
                CountryManager.shared.countries = countries
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
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

    private func updateUI() {
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
        return CountryManager.shared.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryCell {
            let country = CountryManager.shared.countries[indexPath.row]
            cell.country = country
            return cell
        }

        return UITableViewCell()
    }

}


// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCountryCode = CountryManager.shared.countries[indexPath.row].code             // send the country code to detail page
        performSegue(withIdentifier: "goDetails", sender: self)
    }

}

