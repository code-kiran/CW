//
//  TblCell.swift
//  CW
//
//  Created by kiran on 9/14/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit

class TblCell: UITableViewCell {

    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventDistance: UILabel!
   
    func updateView(events: EventModal ){
        eventTitle.text = events.eventName
        eventDescription.text = events.eventDescription
        eventDate.text = events.startDate
        eventDistance.text = events.distance
        
        
        
    }

}
