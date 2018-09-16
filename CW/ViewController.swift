//
//  ViewController.swift
//  CW
//
//  Created by kiran on 9/13/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    let baseUrl = "http://api.yeahviva.com/Events/getEventListingForWheel.json"
    let token:[String: Any] = ["token": "i3rq9jj9f2wy42bxldknnzr7o77pyzfi87yx0gjm"]
    
    var eventArray:[EventModal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
         getData(fromUrl: baseUrl)
    }
    
    func getData(fromUrl: String){
        Alamofire.request(fromUrl, method: .post, parameters: token, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            let responseData = response.result.value as? [String: Any]
            let dataOutput = responseData!["output"] as? [String: Any]
            let events = dataOutput!["response"] as? NSArray
                if events != nil {
                    for event in events!  {
                        self.eventArray.append(EventModal(eventJson: event as! NSDictionary))
                    }
                    DispatchQueue.main.async {
                        self.tblView.reloadData()
                    }
                    
            }
            }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(eventArray)
        return eventArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? TblCell
         let event = eventArray[indexPath.row]
        cell?.eventTitle.text = event.eventName
        cell?.eventDescription.text = event.eventDescription
        cell?.eventDate.text = event.startDate
        cell?.eventDistance.text = event.distance
        cell?.eventImage.downloadImages(url: event.mainImage!)
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if   let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as? EventDetailVC {
             let event = eventArray[indexPath.row]
            vc.titl = event.eventName
            vc.location = event.location
            vc.desc = event.eventDescription
            vc.dist = event.distance
            vc.end = event.endDate
            vc.start = event.startDate
            vc.price = event.eventPrice
            if let newlat = event.latitude {
                vc.lat = Double(newlat)
            }
            if let newlng = event.longitude {
                vc.lng = Double(newlng)
            }
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
}

