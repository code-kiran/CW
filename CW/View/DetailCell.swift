//
//  DetailTblCell.swift
//  CW
//
//  Created by kiran on 9/19/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit

class DetailTblCell: UITableViewCell {
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var distance: UILabel!
    
    func updateEvent(event: EventModal){
        venue.text = "VENUE: \n" + event.location!
        eventTitle.text = event.eventName
        eventDescription.text = event.eventDescription
        startDate.text = "Start Date and Time: " + event.startDate!
        endDate.text = "End Date and Time: " + event.endDate!
        distance.text = event.distance!  + "km far from you do you . Want to get ticket ?? "
        ticketPrice.text = "Ticket costs: " + event.eventPrice!
        
    }
    
    
}
