//
//  Extensions.swift
//  yape-challenge
//
//  Created by devsodep on 24/04/2023.
//

import Foundation
import UIKit
import MapKit

extension String {
    func cleanHTMLTags() -> String? {
        try? NSAttributedString(
            data: Data(self.utf8),
            options: [.documentType: NSAttributedString.DocumentType.html],
            documentAttributes: nil).string
    }
}

extension UIView {
    func setCornerRadius() {
        self.layer.cornerRadius = 5
    }
    func setCornerRadius(_ rad: CGFloat) {
        self.layer.cornerRadius = rad
    }

    func setCircular() {
        self.layer.cornerRadius = self.frame.height / 2
    }
}

extension UIImageView {
    func loadFrom(URLAddress: String) {
        guard let url = URL(string: URLAddress) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}

extension UIViewController {
    func showError(error: Error) {
        let alert = UIAlertController(
            title: "Alert",
            message: "Problem from API",
            preferredStyle: UIAlertController.Style.alert)
        alert.addAction(
            UIAlertAction(
                title: "ACEPTAR",
                style: UIAlertAction.Style.default,
                handler: nil))
        self.present(alert,
                     animated: true,
                     completion: nil)
    }
}

extension MKMapView {

    func setPin(_ location: CLLocationCoordinate2D,
                title: String = "",
                subTitle: String = "",
                regionRadius: CLLocationDistance = 1000) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        annotation.subtitle = subTitle
        let coordinateRegion = MKCoordinateRegion(
            center: annotation.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
        addAnnotation(annotation)
    }
}
