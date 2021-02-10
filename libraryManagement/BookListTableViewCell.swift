//
//  TableViewCell.swift
//  libraryManagement
//
//  Created by 권지현 on 8/4/20.
//  Copyright © 2020 jiseok kim. All rights reserved.
//

import UIKit

class BookListTableViewCell: UITableViewCell {


    @IBOutlet weak var bookImageView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var bookDate: UILabel!
    @IBOutlet weak var starRating: StarRatingView!
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
