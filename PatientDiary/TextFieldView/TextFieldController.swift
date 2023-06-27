//
//  TextFieldController.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import Foundation
import UIKit
class TextFieldController: UIViewController {
    var configurator:  TextFieldConfigurator?
    let datePicker = UIDatePicker()
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var inputeTextView: UITextField!
    @IBOutlet weak var infoLabel: UILabel!
    var presenter: TextFieldPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateView()
        inputeTextView.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        nextButton.layer.cornerRadius = 8
        
        
    }
    @objc func myTargetFunction(textField: UITextField) {
        presenter.getFormType() == .date ?
        self.showAlert() : self.showMenu(textField: inputeTextView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.updateView()
        self.navigationItem.title = presenter.getNavigationHeaderTitle()
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        presenter.nextPressed()
    }
    
    
}
extension TextFieldController: TextFieldView {
    func updateView() {
        infoLabel.text = presenter.getLableValue()
        inputeTextView.text = ""
        inputeTextView.placeholder = presenter.getPlaceHolder()
        if !presenter.getTextValue().isEmpty {
            inputeTextView.text = presenter.getTextValue()
        }
        nextButton.setTitle(presenter.getButtonText(), for: .normal)
        nextButton.backgroundColor = presenter.getTextValue().isEmpty ? .lightGray : .blue
        nextButton.isEnabled = !presenter.getTextValue().isEmpty
        
    }
    
}
extension TextFieldController {
    func showMenu(textField: UITextField){
        let alert = UIAlertController(title: "Select Post Vaccination Effect", message: nil, preferredStyle: .actionSheet)
        for item in Vaccination.allCases {
            let itemAction = UIAlertAction(title: item.getTitle(), style: .default, handler: { _ in
                self.presenter.updateEffects(effect: item)
            })
            alert.addAction(itemAction)
        }
        
        if let popoverController = alert.popoverPresentationController{
            popoverController.sourceView = textField
            popoverController.sourceRect = textField.bounds
            popoverController.permittedArrowDirections = [.down,.up]
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(){
        let alert = UIAlertController(title: TextFieldConstant.selectDate.rawValue, message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.frame = CGRect(x: 0, y: 40, width: 250, height: 150)
        alert.view.addSubview(datePicker)
        let selectAction = UIAlertAction(title: TextFieldConstant.ok.rawValue, style: .default, handler: { _ in
            self.presenter.updateVaccinationDay(text: self.datePicker.date.getDate())
        })
        let cancelAction = UIAlertAction(title: TextFieldConstant.cancel.rawValue, style: .cancel, handler: nil)
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismiss(){
        self.navigationController?.popViewController(animated: true)
    }
}
