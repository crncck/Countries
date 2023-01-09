//
//  SavedViewController.swift
//  Countries
//
//  Created by Ceren Çiçek on 6.01.2023.
//

import UIKit

class SavedViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!

    var chosenCountryCode = ""
    var savedArray = [Country?]()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()

        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(UINib(nibName: "CountryCell", bundle: nil), forCellReuseIdentifier: "cell")

    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Helpers

    func updateUI() {
        self.navigationItem.title = "Countries"

    }

}

// MARK: - UITableViewDataSource

extension SavedViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedSet.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CountryCell {

            savedArray = Array(savedSet)
            let country = savedArray[indexPath.row]
            cell.country = country
            return cell
        }

        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate

extension SavedViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        savedArray = Array(savedSet)
        chosenCountryCode = savedArray[indexPath.row]?.code ?? ""
        performSegue(withIdentifier: "goSavedDetails", sender: self)
    }

}
