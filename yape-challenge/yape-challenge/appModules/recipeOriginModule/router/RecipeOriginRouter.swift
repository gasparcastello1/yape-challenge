//
//  RecipeOriginRouter.swift
//  yape-challenge
//
//  Created by devsodep on 26/04/2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class RecipeOriginRouter: RecipeOriginPresenterToRouterProtocol {
    var navigationController: UINavigationController?

    func present(navigationController: UINavigationController,
                 location: CLLocationCoordinate2D,
                 modelSelected: RecipeModel) {
        self.navigationController = navigationController

        let view = RecipeRouter.mainstoryboard
            .instantiateViewController(
                withIdentifier: "RecipeOriginViewController"
            ) as! RecipeOriginViewController

        let presenter: RecipeOriginViewToPresenterProtocol =
        RecipeOriginPresenter()

        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        presenter.modelSelected = modelSelected
        presenter.location = location

        navigationController.pushViewController(view, animated: true)
    }

    func launchInMapApp(data: RecipeModel,
                        location: CLLocationCoordinate2D) {
        let regionSpan = MKCoordinateRegion(center: location,
                                            latitudinalMeters: 300000,
                                            longitudinalMeters: 300000)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(
                mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(
                mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: location,
                                    addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = data.title
        mapItem.openInMaps(launchOptions: options)
    }
}
