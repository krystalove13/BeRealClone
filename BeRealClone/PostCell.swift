//
//  PostCell.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/19/26.
//

import UIKit
import ParseSwift

class PostCell: UITableViewCell {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with post: Post) {
        captionLabel.text = post.caption
        usernameLabel.text = post.user?.username ?? "Anonymous"

        // Load image from ParseFile URL
        if let imageFile = post.imageFile,
           let imageUrl = imageFile.url {
            URLSession.shared.dataTask(with: imageUrl) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.postImageView.image = image
                    }
                }
            }.resume()
        }
    }
}
