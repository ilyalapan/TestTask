//
//  DetailViewController.swift
//  TestTask
//
//  Created by Ilya Lapan on 15/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {

    
    var product: Product?
    
    @IBOutlet weak var screenShotView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var taglineTextView: UITextView!
    
    @IBOutlet weak var upvotesLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenShotView.sd_setImage(with: product?.screenShotURL)
        nameLabel.text = product?.name
        taglineTextView.text = product?.tagline
        if let upvotes = product?.upvotes {
            upvotesLabel.text = String(upvotes)
        }
        else {
            upvotesLabel.text = ""
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getItButtonPressed(_ sender: AnyObject) {
        
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "webSegue" {
            if let destination = segue.destination as? WebDetailViewController {
                destination.URL = product?.detailURL
            }
        }
    }
    
    
    

}
