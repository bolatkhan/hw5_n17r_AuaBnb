 //
//  CityTableViewController.swift
//  AuaBnB
//
//  Created by user on 14.06.16.
//  Copyright © 2016 Roborzoid. All rights reserved.
//

import UIKit
import KFSwiftImageLoader

class CityTableViewController: UITableViewController {
    
    var cities = [City2]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.findCityAsync()
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CityCell", forIndexPath: indexPath) as! CityTableViewCell
        cell.cityTitle.text = cities[indexPath.row].title
        if let url = cities[indexPath.row].image {
            cell.cityImage.loadImageFromURLString(url, placeholderImage: UIImage(named: "placeholder"), completion: nil)
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("SegueHataTVC", sender: indexPath)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        //SegueHataTVC
        if segue.identifier == "SegueHataTVC"{
            let hataTVC = segue.destinationViewController as! HataTableViewController
            let index = sender  as! NSIndexPath
            hataTVC.city = cities[index.row]
        }
    }
    
    
    // MARK: - Backendless
    func findCityAsync() {
        let dataStore = Backendless.sharedInstance().data.of(City2.ofClass())
        dataStore.find(
            { (result: BackendlessCollection!) -> Void in
                let cities = result.getCurrentPage()
                for obj in cities {
                    let city = obj as! City2
                    self.cities.append(city)
                }
                self.tableView.reloadData()
            },
            error: { (fault: Fault!) -> Void in
                print("Server reported an error: \(fault)")
        })
    }
}
