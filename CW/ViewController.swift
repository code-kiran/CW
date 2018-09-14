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
    let token:[String: Any] = [
        "token": "i3rq9jj9f2wy42bxldknnzr7o77pyzfi87yx0gjm"
    ]
    
    var eventArray:[EventModal] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getData(fromUrl: baseUrl)
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    func getData(fromUrl: String){
        Alamofire.request(fromUrl, method: .post, parameters: token, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
          //  print(response)
            let responseData = response.result.value as? [String: Any]
            let dataOutput = responseData!["output"] as? [String: Any]
            let events = dataOutput!["response"] as? NSArray
                if events != nil {
                    for event in events!  {
                        self.eventArray.append(EventModal(eventJson: event as! NSDictionary))
                       // print(self.eventArray)
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
        
        
//        if eventArray[indexPath.row].isRunning == 1{
//            cell.textLabel?.text = "going"
//        } else {
//            cell.textLabel?.text = "not going"
//        }
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if   let vc = storyboard?.instantiateViewController(withIdentifier: "EventDetailVC") as? EventDetailVC {
             let event = eventArray[indexPath.row]
            let venue = event.location
            let lat = event.latitude
            let lng = event.longitude
            let tite = event.eventName
            let desc = event.eventDescription
            let start = event.startDate
            let end = event.endDate
            let price = event.eventPrice
            let dist = event.distance
            
            vc.titl = tite
            vc.location = venue
            vc.desc = desc
            
            if let newDist = dist {
                vc.dist = Int(newDist)
            }else {
                vc.dist = 10
            }
            
            vc.end = end
            vc.start = start
            vc.price = price
            
            if let newlat = lat {
                vc.lat = Double(newlat)
            }
       
            
            if let newlng = lng {
                vc.lng = Double(newlng)
            }
            
            self.present(vc, animated: true, completion: nil)
        }
      
        
    }
    
    
}

