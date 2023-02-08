import Foundation
import UIKit

protocol RecipeListTableViewModel {
    var recipes: [Recipe] { get }
    var didChange: () -> Void { get set }
    var showError: (String) -> Void { get set }
}

class RecipeListTableViewController: UITableViewController {
    private enum Constants {
        static let cellIdentifier = "RecipeCell"
    }

    private var viewModel: RecipeListTableViewModel
    init(viewModel: RecipeListTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureExternalStyle()
        configureTableView()
        bindViewModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }

    private func bindViewModel() {
        viewModel.didChange = { [weak self] in
            self?.tableView.reloadData()
        }
        viewModel.showError = { [weak self] message in
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
    }

    private func configureExternalStyle() {
        title = "Recipe List"
        tabBarItem = UITabBarItem(title: "List", image: UIImage(systemName: "list.dash"), tag: 0)
    }

    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.recipes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.recipes[indexPath.row].title
        cell.contentConfiguration = content
        return cell
    }
}
