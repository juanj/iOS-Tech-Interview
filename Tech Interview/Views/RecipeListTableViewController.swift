import Foundation
import UIKit

protocol RecipeListTableViewModel {
    var recipes: [Recipe] { get }
    var didChange: () -> Void { get set }
    var showError: (String) -> Void { get set }
    func willShow(index: Int)
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
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? RecipeTableViewCell
        else { fatalError("Failed to dequeue cell of type RecipeTableViewCell") }

        cell.configure(with: viewModel.recipes[indexPath.row])

        return cell
    }

    override func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willShow(index: indexPath.row)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}
