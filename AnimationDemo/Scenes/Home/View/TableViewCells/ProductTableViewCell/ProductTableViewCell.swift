//
//  ProductTableViewCell.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit
import UIComponents

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var appProductView: AppProductView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
