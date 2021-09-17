//
//  SegmentTableViewCell.swift
//  AnimationDemo
//
//  Created by Fouad Bakour on 05/09/2021.
//

import UIKit
import UIComponents

class SegmentTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView?
    @IBOutlet weak var appSegment: AppSegment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.containerView?.roundCorners([.topLeft, .topRight], radius: 20)
        }
    }
}
