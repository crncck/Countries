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
    }


}
