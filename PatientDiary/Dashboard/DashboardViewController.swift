//
//  DashboardViewController.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
import UIKit
import UserNotifications
class DashboardViewController: UIViewController {
    var presenter: DashboardViewPresenter!
    var configurator:  DashboardViewConfigurator?
    var counter = 0
    @IBOutlet weak var studiesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.studiesTableView.register(UINib(nibName: StudyTitleCell.identifier, bundle: nil), forCellReuseIdentifier: StudyTitleCell.identifier)
        studiesTableView.separatorStyle = .none
        self.navigationItem.title = presenter.getNavigationHeaderTitle()
        UNUserNotificationCenter.current().delegate = self
        presenter.viewWillAppear()
        let info = presenter.getNotificationInfo()
        LocatNotification.shared.sendNotification(title: info.title, body: info.body)

    }
   
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewWillAppear()
    }
    
}

extension DashboardViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let model = presenter.getStudyModel(at: indexPath.row) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: StudyTitleCell.identifier) as! StudyTitleCell
            cell.configure(model: model, isVisited: presenter.isCellInteractive(index: indexPath))
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  !presenter.isCellInteractive(index: indexPath) {
            self.showAlert(message: StudyStringConstant.completePrevForms.rawValue)
            return
        }
        presenter.didTapOnRow(indexPath: indexPath, delegate: self)
    }
}

extension DashboardViewController: TextFieldDelegate {
    func updateForms(form: [Forms], indexPath: IndexPath?) {
        presenter.updateModel(indexPath: indexPath, forms: form)
    }
}

extension DashboardViewController: DashboardView {
    func showToast(text: String) {
        self.showAlert(message: text)
    }
    
    
    func dismiss(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func reloadData() {
        self.studiesTableView.reloadData()
    }

}
extension DashboardViewController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
        let content = UNMutableNotificationContent()
        counter += 1
        let info = presenter.getNotificationInfo()
        content.title = info.title
        content.body = info.body
        content.sound = .default
        let req = UNNotificationRequest(identifier: notification.request.identifier, content: content , trigger: notification.request.trigger)
        UNUserNotificationCenter.current().add(req) {(error) in
            if let error = error {
                print("Failed")
            }
        }
        completionHandler([.banner, .list, .badge])
    }

}
