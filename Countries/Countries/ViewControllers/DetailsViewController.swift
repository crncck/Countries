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

    // MARK: - Properties

    var chosenCountryCode = ""
    var wikiDataId: String = ""
    var imageString: String = ""
    var savedArray = [Country?]()

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var savedButton: UIBarButtonItem!

    let customButton = UIButton.init(type: .custom)

    var countryDetails : CountryDetail? {
        didSet {
            DispatchQueue.main.async {
                self.savedArray = Array(savedSet)
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

    // MARK: - API

    func fetchCountryDetails(code: String) {

        let countryDetailsRequest = CountryDetailsService(countryCode: code)
        countryDetailsRequest.getCountryDetails { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let country):
                self?.countryDetails = country
            }
        }

    }

    // MARK: - Actions

    @IBAction func moreInfoButtonClicked(_ sender: Any) {
        guard let url = URL(string: "https://www.wikidata.org/wiki/\(wikiDataId)") else {
          return
        }

        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true

        let vc = SFSafariViewController(url: url, configuration: config)
        present(vc, animated: true)
    }

    // MARK: - Helpers

    func updateUI() {
        self.countryCodeLabel.text = self.countryDetails?.code
        self.navigationItem.title = self.countryDetails?.name
        self.wikiDataId = self.countryDetails?.wikiDataId ?? ""
        self.imageString = self.countryDetails?.flagImageUri ?? ""

        //navigationItem.leftBarButtonItem = UIBarButtonItem(customView: customButton)

        for country in savedArray {
            print(country?.code)
            if country?.code == countryDetails?.code {
                print("iden")
                //savedButton
            }
        }

        /*
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 20, height: 80)
        //activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)

         */

        let webView = WKWebView(frame: CGRect(x: 0, y: 0, width: self.flagImageView.frame.width, height: self.flagImageView.frame.height))
        guard let imageUrl = URL(string: imageString) else { return }
        let urlRequest = URLRequest(url: imageUrl)
        webView.load(urlRequest)
        self.flagImageView.addSubview(webView)
    }

}




