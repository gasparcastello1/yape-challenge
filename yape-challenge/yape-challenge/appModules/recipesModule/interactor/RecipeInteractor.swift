//
//  RecipeInteractor.swift
//  yape-challenge
//
//  Created by devsodep on 23/04/2023.
//

import Foundation
import Kingfisher

class RecipeInteractor: PresenterToInteractorProtocol{
    weak var presenter: InteractorToPresenterProtocol?

    func request<T: Decodable>(
        _ urlString: String,
        modelType: T.Type,
        parameters: [String: Any]? = nil,
        completion : @escaping (Result<T, Error>) -> Void) {
            guard let url = URL(string: urlString) else {
                return
            }
            var request = URLRequest(url: url)

            if let parameters,
               let httpBodyWithParameters = try? JSONSerialization
                .data(withJSONObject: parameters) {
                request.httpBody = httpBodyWithParameters
            }
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let response = response as? HTTPURLResponse {
                    print("--> Response code \(response.statusCode)")
                }
                if let error  {
                    completion(.failure(error))
                } else if let data {
                    DispatchQueue.main.async {
                        completion(
                            Result {
                                try JSONDecoder()
                                    .decode(T.self,
                                            from: data)})
                    }
                }
            }.resume()

        }

    func fetchRecipe() {
        request(AppConstants.apiRecipeList,
                modelType: RecipeListModel.self) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.cacheImages(data)
                self.presenter?.recipeFetchedSuccess(modelSelected: data)
            case .failure(let error):
                self.presenter?.recipeFetchFailed(error: error)
            }
        }
    }

    func cacheImages(_ data: RecipeListModel) {
        let urls = data.recipes
            .compactMap { URL(string: $0.image) }
        ImagePrefetcher(urls: urls) {
            skipped, failed, completed in
            print("These resources are prefetched: \(completed)")
            print("These resources are skipped: \(skipped)")
            print("These resources are failed: \(failed)")
        }.start()
    }

}
