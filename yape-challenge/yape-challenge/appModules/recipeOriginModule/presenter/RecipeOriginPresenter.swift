//
//  RecipeOriginPresenter.swift
//  yape-challenge
//
//  Created by devsodep on 26/04/2023.
//

import Foundation
import UIKit
import CoreLocation

class RecipeOriginPresenter: RecipeOriginViewToPresenterProtocol {

    weak var view: RecipeOriginPresenterToViewProtocol?
    var router: RecipeOriginPresenterToRouterProtocol?
    var modelSelected: RecipeModel?
    var location: CLLocationCoordinate2D?

    func launchInMapApp() {
        guard let modelSelected, let location else { return }
        router?.launchInMapApp(data: modelSelected,
                               location: location)
    }

}
