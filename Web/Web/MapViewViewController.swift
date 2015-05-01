//
//  MapViewViewController.swift
//  Web
//
//  Created by pomn on 4/30/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var shops: [Shop]?
    var center: CLLocationCoordinate2D?

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.mapView.mapType = MKMapType.Hybrid
        
        if (self.center != nil) {
            self.centerMapOnLocation(self.center!, regionRadius: 500)
        }
        
        if (self.shops != nil) {
            for shop in self.shops! {
                self.mapView.addAnnotation(shop)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func centerMapOnLocation(location: CLLocationCoordinate2D, regionRadius: CLLocationDistance) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }

}
