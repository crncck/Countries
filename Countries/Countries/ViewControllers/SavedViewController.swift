//
//  SavedViewController.swift
//  Countries
//
//  Created by Ceren Çiçek on 6.01.2023.
//

import UIKit

class SavedViewController: UIViewController {

    public var chosenCountryCode = ""

    private var savedCountriesArray: [Country] = []

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Countries"

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "cell")

        updateUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        updateUI()
    }

    // MARK: - Helpers

    private func updateUI() {
        savedCountriesArray = CountryManager.shared.filterSavedCountries()              // get array of countries which are saved to user defaults
        tableView.reloadData()
    }

    // MARK: - Actions

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsViewController = segue.destination as? DetailsViewController {
            detailsViewController.chosenCountryCode = chosenCountryCode
        }
    }

}


// MARK: - UITableViewDataSource

extension SavedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedCountriesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryCell {
            let country = savedCountriesArray[indexPath.row]
            cell.country = country
            cell.delegate = self
            return cell
        }

        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension SavedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenCountryCode = savedCountriesArray[indexPath.row].code                 // send country code to detail page
        performSegue(withIdentifier: "goSavedDetails", sender: self)
    }

}

// MARK: - CountryCellDelegate

extension SavedViewController: CountryCellDelegate {

    func didClickedSavedButton() {
        updateUI()
    }

}
