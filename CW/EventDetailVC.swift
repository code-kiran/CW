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
    @IBOutlet weak var mymapView: UIView!
    @IBOutlet weak var venue: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var ticketPrice: UILabel!
    @IBOutlet weak var distance: UILabel!
    var lat: Double?
    var lng: Double?
    var location: String?
    var start: String?
    var end: String?
    var price: String?
    var dist: String?
    var titl:String?
    var desc: String?
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        venue.text = "VENUE: \n" + location!
        eventTitle.text = titl
        eventDescription.text = desc
        startDate.text = "Start Date and Time: " + start!
        endDate.text = "End Date and Time: " + end!
        distance.text = dist!  + "km far from you do you . Want to get ticket ?? "
        ticketPrice.text = "Ticket costs: " + price!
    }
    
    // I suggest moving your code to viewDidLayoutSubviews: so your mapView frame is set after the googleMapView has stretched to fill the screen,
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let camera = GMSCameraPosition.camera(withLatitude: lat!, longitude: lng!, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.mymapView.bounds, camera: camera)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
        marker.title = location
        marker.snippet = "Australia"
        marker.map = mapView
        self.mymapView.addSubview(mapView)

    }
    
    @IBAction func getTicketButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
