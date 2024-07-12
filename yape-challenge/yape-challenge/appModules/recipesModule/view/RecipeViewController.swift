//
//  ViewController.swift
//  yape-challenge
//
//  Created by devsodep on 20/04/2023.
//

import UIKit
import Kingfisher

class RecipeViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var presenter: ViewToPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTable()
        presenter?.startFetchingRecipes()
        title = "Listado"
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.backgroundColor = UIColor(
            white: 1,
            alpha: 0.5)
    }

    func setTable() {
        searchBar.delegate = self

        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.register(
            UINib(nibName:
                    "RecipeTableViewCell",
                  bundle: nil),
            forCellReuseIdentifier: "RecipeTableViewCell")
    }

}

extension RecipeViewController: PresenterToViewProtocol {

    func updateUI() {
        tableView.reloadData()
    }

}

extension RecipeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        presenter?.textdidChanged(searchText: searchText)
    }
}

extension RecipeViewController: UITableViewDataSource,
                                UITableViewDelegate,
                                UITableViewDataSourcePrefetching {

    func tableView(_ tableView: UITableView,
                   prefetchRowsAt indexPaths: [IndexPath]) {
        presenter?.prefetchTableImages(indexPaths: indexPaths)
    }


    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return presenter?.recipesCount ?? 0
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = presenter?.getRecipe(at: indexPath.row),
              let cell = tableView
            .dequeueReusableCell(
                withIdentifier: "RecipeTableViewCell",
                for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.setCell(with: model)
        return cell
    }

    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        guard let data = presenter?.getRecipe(at: indexPath.row) else { return }
        presenter?.showRecipeDetailController(data: data)
    }

}
