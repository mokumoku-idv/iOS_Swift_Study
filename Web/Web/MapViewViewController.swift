//
//  MapViewViewController.swift
//  Web
//
//  Created by pomn on 4/30/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    var shops: [Shop]?
    var center: CLLocationCoordinate2D?

    //@IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func mapTypeSegmentPressed(sender: UISegmentedControl) {
        let segmentedControl = sender as UISegmentedControl
        switch segmentedControl.selectedSegmentIndex {
            case 0:
                mapView.mapType = kGMSTypeNormal
            case 1:
                mapView.mapType = kGMSTypeSatellite
            case 2:
                mapView.mapType = kGMSTypeHybrid
            case 3:
                mapView.mapType = kGMSTypeTerrain
            case 4:
                mapView.mapType = kGMSTypeNone
            default:
                mapView.mapType = mapView.mapType
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.mapView.mapType = MKMapType.Hybrid
//        
//        if (self.center != nil) {
//            self.centerMapOnLocation(self.center!, regionRadius: 500)
//        }
//        
//        if (self.shops != nil) {
//            for shop in self.shops! {
//                self.mapView.addAnnotation(shop)
//            }
//        }
        
        self.mapView.delegate = self
        //self.gmsMapView.settings.rotateGestures = false
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        self.mapView.settings.indoorPicker = true
        
        if (self.center != nil) {
            var camera = GMSCameraPosition.cameraWithTarget(self.center!, zoom: 15.0)
            self.mapView.myLocationEnabled = true
            self.mapView.camera = camera
        }
        
        if (self.shops != nil) {
            for shop in self.shops! {
                var marker = GMSMarker()
                marker.position = shop.coordinate
                marker.title = shop.title
                marker.snippet = shop.subtitle
                marker.map = self.mapView
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
    
    
    
//    func centerMapOnLocation(location: CLLocationCoordinate2D, regionRadius: CLLocationDistance) {
//        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, regionRadius * 2.0, regionRadius * 2.0)
//        mapView.setRegion(coordinateRegion, animated: true)
//    }

}
