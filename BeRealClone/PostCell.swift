//
//  PostCell.swift
//  BeRealClone
//

import UIKit
import ParseSwift

class PostCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var blurView: UIVisualEffectView!

    private var imageDataRequest: URLSessionDataTask?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Pin blurView directly to all 4 edges of postImageView programmatically
        blurView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: postImageView.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: postImageView.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: postImageView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: postImageView.trailingAnchor)
        ])
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        imageDataRequest?.cancel()
    }

    func configure(with post: Post) {
        if let user = post.user {
            usernameLabel.text = user.username
        }

        captionLabel.text = post.caption

        // Always bring blur to the front of the content view
        contentView.bringSubviewToFront(blurView)

        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            imageDataRequest = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                guard let self = self, let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self.postImageView.image = image
                    self.contentView.bringSubviewToFront(self.blurView)
                }
            }
            imageDataRequest?.resume()
        }

        // MARK: - Blur Logic
        print("--- Checking Blur for \(User.current?.username ?? "Anonymous") ---")
        if let currentUser = User.current,
           let lastPostedDate = currentUser.lastPostedDate,
           let postCreatedDate = post.createdAt,
           let diffHours = Calendar.current.dateComponents([.hour], from: postCreatedDate, to: lastPostedDate).hour {

            let isRecent = abs(diffHours) < 24
            blurView.isHidden = isRecent
            print("User posted within 24h: \(isRecent) -> isHidden: \(isRecent)")
        } else {
            blurView.isHidden = false
            print("User has NOT posted -> isHidden: false (BLUR ACTIVE)")
        }
    }
}
