//
//  StudyTitleCell.swift
//  PatientDiary
//
//  Created by Bhakti MALKHARE on 26/06/23.
//

import UIKit

class StudyTitleCell: UITableViewCell {
    static var identifier = "StudyTitleCell"

    @IBOutlet weak var studyNameLabel: UILabel!
    @IBOutlet weak var outerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        outerView.layer.borderWidth = 0.5
        outerView.layer.borderColor = UIColor.lightGray.cgColor
        outerView.layer.cornerRadius = 8
    }
    func configure(model: Studies?,isVisited: Bool) {
        guard let model = model else {
            return
        }
        studyNameLabel.text = model.name
        outerView.backgroundColor = isVisited ? .clear : Colors.lightGray.uiColor

    }
    
}
