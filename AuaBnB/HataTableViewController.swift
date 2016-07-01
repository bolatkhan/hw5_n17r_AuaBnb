//
//  HataTableViewController.swift
//  AuaBnB
//
//  Created by user on 14.06.16.
//  Copyright © 2016 Roborzoid. All rights reserved.
//

import UIKit

class HataTableViewController: UITableViewController {
    var city: City2!
    var hata = [Hata]()
    var tempImageUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.findHataAsync(self.city)
    }
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hata.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HataCell", forIndexPath: indexPath) as! HataTableViewCell
        
        cell.hataTitle.text = hata[indexPath.row].title
        cell.hataPrice.text = "\(hata[indexPath.row].price) тнг"

        if let url = hata[indexPath.row].image {
            cell.hataImage.loadImageFromURLString(url, placeholderImage: UIImage(named: "placeholder"), completion: nil)
        }
        return cell
    }
    
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tempImageUrl = hata[indexPath.row].image
        self.performSegueWithIdentifier("segueDetail", sender: indexPath)
    }
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //SegueHataTVC
        if segue.identifier == "segueDetail"{
           let detailHataTVC = segue.destinationViewController as! detailsViewController
           let index = sender  as! NSIndexPath
            detailHataTVC.hataDetail = hata[index.row]
            detailHataTVC.imageUrl = self.tempImageUrl
        }
    }

    // MARK: - Backendless
    func findHataAsync(city: City2) {
        
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = "city.objectId = \'\(city.objectId!)\'"

        
    let dataStore = Backendless.sharedInstance().data.of(Hata.ofClass())
        
        dataStore.find(dataQuery, response: {(result: BackendlessCollection!) in
            //code
            let hatas = result.getCurrentPage()
            for obj in hatas {
                let hata = obj as! Hata
                self.hata.append(hata)
            }
            self.tableView.reloadData()
        }) { (error: Fault!) in
            print("Server reported an error: \(error)")

        }
    }
}
