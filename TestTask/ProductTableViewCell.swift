//
//  ProductTableViewCell.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import UIKit
import AlamofireImage

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productUpvotesLabel: UILabel!
    
    
    func configureCell(product: Product)
    {
        
        productNameLabel.text = product.name
        productUpvotesLabel.text = String(product.upvotes)
        //thumbnailView.sd_setImage(with: product.imageURL)
        thumbnailView.image = nil
        thumbnailView.af_setImage(withURL: product.imageURL)
    
    }
    
    
}
