//
//  DomainCell.swift
//  IOS App Architecture
//
//  Created by Mansoor Ali on 26/06/2023.
//

import UIKit
import Reusable
import Data

class DomainCell: UITableViewCell, Reusable {

    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var detail: UILabel!
    @IBOutlet weak private var link: UILabel!
    @IBOutlet weak private var icon: UIImageView!
    
    func set(domain: Domain) {
        title.text = domain.api
        detail.text = domain.description
        link.text = domain.link
        icon.image = domain.https ? UIImage(named: "check") : UIImage(named: "uncheck")
    }
}
