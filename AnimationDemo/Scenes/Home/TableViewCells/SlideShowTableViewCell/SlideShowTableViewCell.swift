//
//  SlideShowTableViewCell.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit
import UIComponents

class SlideShowTableViewCell: UITableViewCell {

    @IBOutlet weak var appSlideShow: AppSlideShow?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

}
