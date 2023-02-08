import Foundation
import UIKit
import Kingfisher

class RecipeTableViewCell: UITableViewCell {
    private let recipeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private let recipeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()

    private let overlay: UIView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        buildView()
    }

    private func buildView() {
        contentView.addSubview(recipeImageView)
        recipeImageView.translatesAutoresizingMaskIntoConstraints = false
        recipeImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        recipeImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        recipeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        recipeImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        contentView.addSubview(overlay)
        overlay.translatesAutoresizingMaskIntoConstraints = false
        overlay.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        overlay.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        overlay.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        overlay.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        contentView.addSubview(recipeTitleLabel)
        recipeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        recipeTitleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        recipeTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        recipeTitleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 25).isActive = true
        recipeTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -25).isActive = true
    }

    func configure(with recipe: Recipe) {
        recipeTitleLabel.text = recipe.title
        recipeImageView.kf.cancelDownloadTask()
        recipeImageView.kf.setImage(with: recipe.imageURL, placeholder: UIImage(systemName: "photo"))
    }
}
