//
//  SignUpViewController.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/18/26.
//

import UIKit
import ParseSwift

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSignUpTapped(_ sender: Any) {
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(description: "All fields are required.")
            return
        }

        var newUser = User()
        newUser.username = username
        newUser.email = email
        newUser.password = password

        newUser.signup { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("✅ Signed up: \(user)")
                    NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
    }

    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Sign Up Failed", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
