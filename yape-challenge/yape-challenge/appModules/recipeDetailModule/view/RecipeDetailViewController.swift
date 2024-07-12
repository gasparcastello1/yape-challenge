//
//  RecipeDetailViewController.swift
//  yape-challenge
//
//  Created by devsodep on 24/04/2023.
//

import UIKit
import Kingfisher
import MapKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var presenter: RecipeDetailViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
        title = "Detalles"
    }

    private func setup() {
        guard let modelSelected = presenter?.modelSelected,
              let location = presenter?.location else { return }
        let url = modelSelected.image
        recipeImage.kf.setImage(with: URL(string: url)!)
        titleLabel.text = modelSelected.title.uppercased()
        descriptionLabel.text = modelSelected.summary.cleanHTMLTags()
        mapView.setCornerRadius()
        mapView.setPin(location,
                       title: modelSelected.title.uppercased(),
                       regionRadius: 300000)
        mapView.delegate = self
    }
}

extension RecipeDetailViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        presenter?.showRecipeOriginController()
    }
}

extension RecipeDetailViewController: RecipeDetailPresenterToViewProtocol {

    func updateUI() {
        setup()
    }

}
