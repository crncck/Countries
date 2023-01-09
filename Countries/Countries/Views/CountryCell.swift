//
//  CountryCell.swift
//  Countries
//
//  Created by Ceren Çiçek on 7.01.2023.
//

import UIKit

protocol CountryCellDelegate {

    func didClickedSavedButton()

}

class CountryCell: UITableViewCell {

    var delegate: CountryCellDelegate?

    var country: Country? {
        didSet {
            updateUI()
        }
    }

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

        // change the selection of the saved button if the country is saved in user defaults
        savedButton.isSelected = Utils.checkIfCountryIsSaved(countryCode: country?.code ?? "")
    }

    // MARK: - Actions

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    // adds or removes country code from user defaults when it is clicked
    @IBAction func savedButtonClicked(_ sender: Any) {
        savedButton.isSelected = !savedButton.isSelected

        if savedButton.isSelected {
            Utils.saveCountryToUserDefaults(countryCode: country?.code ?? "")
        } else {
            Utils.removeCountryFromUserDefaults(countryCode: country?.code ?? "")
        }

        delegate?.didClickedSavedButton()
    }

}
