//
//  PostViewController.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/19/26.
//

import UIKit
import PhotosUI
import ParseSwift

class PostViewController: UIViewController, PHPickerViewControllerDelegate {

    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var captionTextField: UITextField!

    private var pickedImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSelectPhotoTapped(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        guard let provider = results.first?.itemProvider,
              provider.canLoadObject(ofClass: UIImage.self) else { return }

        provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
            guard let image = image as? UIImage else { return }
            DispatchQueue.main.async {
                self?.previewImageView.image = image
                self?.pickedImage = image
            }
        }
    }

    @IBAction func onPostPhotoTapped(_ sender: Any) {
        guard let image = pickedImage,
              let imageData = image.jpegData(compressionQuality: 0.1) else {
            showAlert(message: "Please select an image first.")
            return
        }

        let imageFile = ParseFile(name: "image.jpg", data: imageData)
        var post = Post()
        post.imageFile = imageFile
        post.caption = captionTextField.text
        post.user = User.current

        post.save { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.navigationController?.popViewController(animated: true)
                case .failure(let error):
                    self?.showAlert(message: error.localizedDescription)
                }
            }
        }
    }

    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
