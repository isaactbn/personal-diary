//
//  DiaryListCell.swift
//  Personal-Diary
//
//  Created by Isaac on 11/23/22.
//

import UIKit

class DiaryListCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var archiveImg: UIImageView!
    @IBOutlet weak var archiveLabel: UILabel!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardView.setupRadius(type: .custom(12))
        cardView.layer.applySketchShadow(color: #colorLiteral(red: 0, green: 0.21322909, blue: 0.5749545693, alpha: 1), alpha: 0.06, x: -1, y: 1, blur: 6, spread: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
