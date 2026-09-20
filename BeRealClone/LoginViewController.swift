//
//  LoginViewController.swift
//  BeRealClone
//
//  Created by Krystal Lewin on 9/18/26.
//

import UIKit
import ParseSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLoginTapped(_ sender: Any) {
        guard let username = usernameField.text, !username.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            showAlert(description: "Please enter both username and password.")
            return
        }

        // Log in the Parse user
        User.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    print("✅ Logged in as: \(user)")
                    NotificationCenter.default.post(name: Notification.Name("login"), object: nil)
                case .failure(let error):
                    self?.showAlert(description: error.localizedDescription)
                }
            }
        }
    }

    private func showAlert(description: String?) {
        let alertController = UIAlertController(title: "Unable to Log In", message: description ?? "Unknown error", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true)
    }
}
