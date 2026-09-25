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

    // MARK: - Photo Library Action
    @IBAction func onSelectPhotoTapped(_ sender: Any) {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true)
    }

    // MARK: - Camera Action (Lab 3: Step 1A)
    @IBAction func onTakePhotoTapped(_ sender: Any) {
        // Ensure the camera is available
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(message: "Camera is not available on this device (e.g. Simulator). Please use the photo picker.")
            return
        }

        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }

    // MARK: - PHPicker Delegate
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

    // MARK: - Post Creation & Updating lastPostedDate
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

        // 1. Save the post to Parse
        post.save { [weak self] result in
            switch result {
            case .success:
                // 2. Update the logged-in user's lastPostedDate
                if var currentUser = User.current {
                    currentUser.lastPostedDate = Date()
                    
                    currentUser.save { [weak self] userResult in
                        DispatchQueue.main.async {
                            switch userResult {
                            case .success:
                                self?.navigationController?.popViewController(animated: true)
                            case .failure(let error):
                                self?.showAlert(message: "Failed to update user timestamp: \(error.localizedDescription)")
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.navigationController?.popViewController(animated: true)
                    }
                }

            case .failure(let error):
                DispatchQueue.main.async {
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

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension PostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        guard let image = (info[.editedImage] ?? info[.originalImage]) as? UIImage else {
            print("❌ Unable to retrieve camera image")
            return
        }

        previewImageView.image = image
        pickedImage = image
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
