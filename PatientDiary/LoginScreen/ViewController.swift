//
//  ViewController.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    var configurator:  LoginViewConfigurator?
    var presenter: LoginPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = LoginViewConfiguratorImpl(viewController: self)
        configurator?.configure()
    }

    @IBAction func loginTapped(_ sender: UIButton) {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else { return }
            
            if let name =  signInResult?.user.profile?.name, let imageUrl = signInResult?.user.profile?.imageURL(withDimension: 100), let email = signInResult?.user.profile?.email {
                self.presenter.loginPressed(person: Person(name: name, emailID: email, url: imageUrl, jsonString: ""))
            }
            
          }
    }
    
}

