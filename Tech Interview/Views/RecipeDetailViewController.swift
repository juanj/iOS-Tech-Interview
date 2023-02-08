import Foundation
import UIKit

protocol RecipeDetailViewModel {
    var title: String { get }
    var headerImageURL: URL? { get }
    var summary: String { get }
    var instructions: String { get }
    var didChange: () -> Void { get set }
    var showError: (String) -> Void { get set }
}

class RecipeDetailViewController: UIViewController {
    private let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "photo")
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        return imageView
    }()

    private let summaryTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Summary"
        label.numberOfLines = 0
        return label
    }()

    private let summaryBody: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    private lazy var summaryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [summaryTitle, summaryBody])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    private let instructionsTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 18)
        label.text = "Instructions"
        label.numberOfLines = 0
        return label
    }()

    private let instructionsBody: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 12)
        label.numberOfLines = 0
        return label
    }()

    private lazy var instructionsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [instructionsTitle, instructionsBody])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()

    private lazy var insetContentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, summaryStackView, instructionsStackView])
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.addSubview(insetContentStackView)
        insetContentStackView.translatesAutoresizingMaskIntoConstraints = false
        insetContentStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        insetContentStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        insetContentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        insetContentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerImageView, contentView])
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(contentStackView)
        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        contentStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor).isActive = true
        contentStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor).isActive = true
        contentStackView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor).isActive = true
        contentStackView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor)
            .isActive = true
        contentStackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor).isActive = true
        return scrollView
    }()

    private var viewModel: RecipeDetailViewModel
    init(viewModel: RecipeDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        configureExternalStyle()
        bindViewModel()
        loadData()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    private func bindViewModel() {
        viewModel.didChange = { [weak self] in
            self?.loadData()
        }
        viewModel.showError = { [weak self] message in
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alertController, animated: true)
        }
    }

    private func configureExternalStyle() {
        title = viewModel.title
        hidesBottomBarWhenPushed = true
    }

    private func loadData() {
        title = viewModel.title
        headerImageView.kf.cancelDownloadTask()
        headerImageView.kf.setImage(with: viewModel.headerImageURL, placeholder: headerImageView.image)
        titleLabel.text = viewModel.title
        summaryBody.text = viewModel.summary
        instructionsBody.text = viewModel.instructions
    }
}
