//
//  detailsViewController.swift
//  AuaBnB
//
//  Created by user on 14.06.16.
//  Copyright © 2016 Roborzoid. All rights reserved.
//

import UIKit

class detailsViewController: UIViewController {
    
    var hataDetail: Hata!
    
    
    
    @IBOutlet weak var imageView: UIImageView!    
    @IBOutlet weak var rooms: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var price: UILabel!
    
    var imageUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rooms.text = "\(hataDetail.title!) комнаты"
        city.text = String(hataDetail.city!.title!)
        price.text = "\(hataDetail.price) тнг"
        imageView.loadImageFromURLString(imageUrl, placeholderImage: UIImage(named: "placeholder"), completion: nil)
    }

    
   
}
