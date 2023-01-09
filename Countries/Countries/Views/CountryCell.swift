//
//  CountryCell.swift
//  Countries
//
//  Created by Ceren Çiçek on 7.01.2023.
//

import UIKit

class CountryCell: UITableViewCell {

    var country: Country? {
        didSet {
            updateUI()
        }
    }

    var savedArray = [Country?]()
    var savedCountriesSet = Set<Country?>()

    // MARK: - Properties

    @IBOutlet private weak var countryNameLabel: UILabel!
    @IBOutlet private weak var borderView: UIView!
    @IBOutlet private weak var savedButton: UIButton!

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        borderView.layer.borderWidth = 2
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.cornerRadius = 8
        savedButton.tintColor = .black

    }

    // MARK: - Helpers

    func updateUI() {
        countryNameLabel.text = country?.name
    }

    // MARK: - Actions

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func savedButtonClicked(_ sender: Any) {
        savedButton.isSelected = !savedButton.isSelected
        var savedCountries = Array(savedCountriesSet)

        if savedButton.isSelected {
            savedCountries.append(country)
            savedSet.insert(country)
            print(savedSet.count)

            /*
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(savedCountries)
                UserDefaults.standard.set(data, forKey:"savedCountries")
            } catch {
                print("Unable to Encode Note (\(error))")
            }
            */
            print("saved")
            let array = Array(savedSet)
            print(array)

        } else {
            savedSet.remove(country)
            print("removed")
            print(savedSet.count)
            let array = Array(savedSet)
            print(array)
        }
    }


}
