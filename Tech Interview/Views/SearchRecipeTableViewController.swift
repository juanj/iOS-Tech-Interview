import Foundation
import UIKit

protocol SearchRecipeTableViewModel {
    var results: [Recipe] { get }
    var didChange: () -> Void { get set }
    var showError: (String) -> Void { get set }
    func didChangeSearch(newSearch: String)
    func willShow(index: Int)
}

class SearchRecipeTableViewController: UIViewController {
    private enum Constants {
        static let cellIdentifier = "RecipeCell"
    }

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private var timer: Timer?

    private var viewModel: SearchRecipeTableViewModel
    init(viewModel: SearchRecipeTableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureExternalStyle()
        configureTableView()
        configureSearchBar()
        bindViewModel()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func configureTableView() {
        tableView.keyboardDismissMode = .interactive
        tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func configureSearchBar() {
        searchBar.delegate = self
    }

    private func configureExternalStyle() {
        title = "Search Recipe"
        tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
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

    private func scheduleSearchCall(text: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            DispatchQueue.main.async {
                self?.viewModel.didChangeSearch(newSearch: text)
            }
        })
    }
}

extension SearchRecipeTableViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return viewModel.results.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? RecipeTableViewCell
        else { fatalError("Failed to dequeue cell of type RecipeTableViewCell") }

        cell.configure(with: viewModel.results[indexPath.row])

        return cell
    }

    func tableView(_: UITableView, willDisplay _: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willShow(index: indexPath.row)
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 250
    }
}

extension SearchRecipeTableViewController: UISearchBarDelegate {
    func searchBar(_: UISearchBar, textDidChange searchText: String) {
        scheduleSearchCall(text: searchText)
    }
}
