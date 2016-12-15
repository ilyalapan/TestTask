//
//  ProductListTableViewController.swift
//  TestTask
//
//  Created by Ilya Lapan on 14/12/2016.
//  Copyright © 2016 ilyalapan. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications

class ProductListTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate, CategorySelectedDelegate {

    @IBOutlet weak var categoryButton: UIButton!
    
    var manager: ProductListManager = ProductListManager()
    
    
    var isLoading: Bool = false
    var isRefreshing: Bool = false
    var isScrollLoadEnabled = true
    
    var categories: [Dictionary<String,AnyObject>] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert,.sound,.badge],
            completionHandler: { (granted,error) in
                print(error)
            }
        )
        
        
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.addSubview(refreshControl!)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let URLString = "https://api.producthunt.com/v1/categories?access_token=591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
        
        Alamofire.request(URLString).responseJSON{ response in
            
            do {
                let result = try RequestHelper.checkResponse(responseJSON: response)
                self.categories = result["categories"] as! [Dictionary<String,AnyObject>]
            }
            catch {
                print("Uncaught Error")
            }
        }

        
    }
    
    func refresh() {
        isRefreshing = true
        isLoading = false
        self.manager.load(){result in
            self.refreshControl?.endRefreshing()
            self.tableView.reloadData()
            self.isRefreshing = false
        }
    }

    
    
    override func viewWillAppear(_ animated: Bool) {
        self.manager.load(){result in
            self.tableView.reloadData()
        }
    }
    
    
    
    // MARK: - Popover

    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    // MARK: - Category Selected
    func categorySelected(index: Int) {
        self.categoryButton.setTitle( categories[index]["name"] as! String?, for: .normal)
        self.manager.category = categories[index]["slug"] as! String
        self.presentedViewController?.dismiss(animated: true, completion: nil)
        self.manager.load(){_ in 
            self.tableView.reloadData()
        }

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return manager.products.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return manager.getNumberOfProductsForSection(section: section)
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Today"
        }
        else {
            return String(section) + " Days Ago"
        }
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as? ProductTableViewCell

        let product = manager.products[indexPath.section][indexPath.row]
        
        cell?.configureCell(product: product)
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == manager.products.count - 1{
            if indexPath.row == manager.products[indexPath.section].count - 1 {
                self.loadMoreData()
            }
            
        }
    }
    
    func loadMoreData() {
        if isLoading || isRefreshing {
            return //Do not load if is already loading
        }
        self.isLoading = true
        self.manager.loadMore(){ result in
            if (result as? ServerRequestResponse == ServerRequestResponse.Success) {
                self.isLoading = false
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = self.manager.products[indexPath.section][indexPath.row]
        self.performSegue(withIdentifier: "detailSegue", sender: product)
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "popoverSegue" {
            let popoverViewController = segue.destination as? CategoryTableViewController
            popoverViewController?.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController?.popoverPresentationController!.delegate = self
            let anchorView = sender as! UIView
            popoverViewController?.popoverPresentationController?.sourceRect = anchorView.bounds
            popoverViewController?.categories = self.categories
            popoverViewController?.delegate = self
        }
        else if segue.identifier == "detailSegue" {
            if let destination = segue.destination as? DetailViewController {
                if let product = sender as? Product {
                    destination.product = product
                }
            }
        }

    }
    


}
