//
//  RecipeOriginViewController.swift
//  yape-challenge
//
//  Created by devsodep on 26/04/2023.
//

import UIKit
import MapKit

class RecipeOriginViewController: UIViewController, MKMapViewDelegate {

    var presenter: RecipeOriginViewToPresenterProtocol?

    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let location = presenter?.location else { return }
        mapView.setPin(location , regionRadius: 300000)
        setup()
        title = "Mapa"
    }

    func setup() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem =
        UIBarButtonItem(
            title: "See in Maps",
            style: .done,
            target: self,
            action: #selector(self.buttonAction))
    }

    @objc func buttonAction() {
        presenter?.launchInMapApp()
    }

}

extension RecipeOriginViewController: RecipeOriginPresenterToViewProtocol {
    func updateUI() {

    }
}
