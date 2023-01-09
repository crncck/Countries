//
//  DetailsViewController.swift
//  Countries
//
//  Created by Ceren Çiçek on 7.01.2023.
//

import UIKit
import WebKit
import SafariServices

class DetailsViewController: UIViewController {

    public var chosenCountryCode = ""
    private var wikiDataId: String = ""
    private var imageString: String = ""

    // MARK: - Properties

    @IBOutlet private weak var flagImageView: UIImageView!
    @IBOutlet private weak var countryCodeLabel: UILabel!
    @IBOutlet private weak var informationButton: UIButton!
    @IBOutlet private weak var savedButton: UIBarButtonItem!

    var countryDetails : CountryDetail? {
        didSet {
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.savedButton.tintColor = .black

        fetchCountryDetails(code: chosenCountryCode)

        informationButton.tintColor = .white


    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let isSaved = Utils.checkIfCountryIsSaved(countryCode: chosenCountryCode)

        // change saved button icon if the country is saved in user defaults
        savedButton.image = isSaved ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
    }

    // MARK: - API

    // requests the country details data of given country code from api
    private func fetchCountryDetails(code: String) {

        let countryDetailsRequest = CountryDetailsService(countryCode: code)
        countryDetailsRequest.getCountryDetails { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let country):
                self?.countryDetails = country                  // store the results in a Country Details object
            }
        }

    }

    // MARK: - Actions

    // redirects user to wiki page of the current country
    @IBAction func moreInfoButtonClicked(_ sender: Any) {
        guard let url = URL(string: "https://www.wikidata.org/wiki/\(wikiDataId)") else {
          return
        }

        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }

    // performs operations of saved button
    @IBAction func savedButtonClicked(_ sender: Any) {
        let isSaved = Utils.checkIfCountryIsSaved(countryCode: chosenCountryCode)           // check if the country is saved in user defaults
        if isSaved {
            Utils.removeCountryFromUserDefaults(countryCode: chosenCountryCode)             // it is already saved, remove from user defaults
            savedButton.image = UIImage(systemName: "star")                                 // turn saved button to unselected icon
        } else {
            Utils.saveCountryToUserDefaults(countryCode: chosenCountryCode)                 // save the country to user defaults
            savedButton.image = UIImage(systemName: "star.fill")                            // turn saved button to selected icon
        }

    }


    // MARK: - Helpers

    func updateUI() {
        self.countryCodeLabel.text = self.countryDetails?.code
        self.navigationItem.title = self.countryDetails?.name
        self.wikiDataId = self.countryDetails?.wikiDataId ?? ""
        self.imageString = self.countryDetails?.flagImageUri ?? ""

        // activity indicator for image view
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: self.flagImageView.frame.midX, y: self.flagImageView.frame.midY, width: 10, height: 80)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)

        // get flag image via url and load in web view
        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.flagImageView.frame.width, height: self.flagImageView.frame.height))
        guard let imageUrl = URL(string: imageString) else { return }
        let urlRequest = URLRequest(url: imageUrl)
        webView.load(urlRequest)
        self.flagImageView.addSubview(webView)

        print(webView.isLoading)


    }

}
