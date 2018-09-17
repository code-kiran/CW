//
//  EventDetailVC.swift
//  CW
//
//  Created by kiran on 9/14/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import GoogleMaps

class EventDetailVC: UIViewController {
    var eventArray = [EventModal]()
    var indePath = Int()
    
    @IBOutlet weak var mymapView: UIView!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var distance: UILabel!
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEventDescriptions()
    }
    
    // I suggest moving your code to viewDidLayoutSubviews: so your mapView frame is set after the googleMapView has stretched to fill the screen,
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let camera = GMSCameraPosition.camera(withLatitude: eventArray[indePath].latitude!, longitude: eventArray[indePath].longitude!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.mymapView.bounds, camera: camera)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: eventArray[indePath].latitude!, longitude: eventArray[indePath].longitude!)
        marker.title = eventArray[indePath].location
        marker.snippet = "Australia"
        marker.map = mapView
        self.mymapView.addSubview(mapView)
    }
    
    func setEventDescriptions() {
        let events = eventArray[indePath]
        venue.text = "VENUE: \n" + events.location!
        eventTitle.text = events.eventName
        eventDescription.text = events.eventDescription
        startDate.text = "Start Date and Time: " + events.startDate!
        endDate.text = "End Date and Time: " + events.endDate!
        distance.text = events.distance!  + "km far from you do you . Want to get ticket ?? "
        ticketPrice.text = "Ticket costs: " + events.eventPrice!
        
    }
    
    @IBAction func getTicketButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
