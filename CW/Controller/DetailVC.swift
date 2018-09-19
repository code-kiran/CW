//
//  EventDetailVC.swift
//  CW
//
//  Created by kiran on 9/14/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import GoogleMaps

class EventDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var eventArray = [EventModal]()
    var indePath = Int()
    @IBOutlet weak var detailTable: UITableView!
    @IBOutlet weak var mymapView: UIView!
    var mapView = GMSMapView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailTable.delegate = self
        detailTable.dataSource = self
    
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailTblCell {
            let eventDetails = eventArray[indePath]
            cell.updateEvent(event: eventDetails)
            return cell

        }
        else {
            return DetailTblCell()
        }
    }
    

    
}
