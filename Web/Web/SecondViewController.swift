//
//  SecondViewController.swift
//  Web
//
//  Created by pomn on 4/15/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate, GMSMapViewDelegate {

    //@IBOutlet weak var mapView: MKMapView!
    //@IBOutlet weak var mapView: GMSMapView!
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
        // Do any additional setup after loading the view, typically from a nib.

        let initialLocation = CLLocation(latitude: 35.6666973, longitude: 139.730563)
        //mapView.delegate = self
        //centerMapOnLocation(initialLocation)
        
        let shop1 = Shop(title: "オービカ モッツァレラバー 東京ミッドタウン店",
            subtitle: "BAR・ラウンジ",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 35.6666973, longitude: 139.730563))
        //mapView.addAnnotation(shop1)
        
        let shop2 = Shop(title: "東京ミッドタウン　東京ミッドタウン・ホールＡ",
            subtitle: "ホール・劇場",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 35.665168773482, longitude: 139.73121491527))
        //mapView.addAnnotation(shop2)
        
        let shop3 = Shop(title: "ROTI 東京ミッドタウン",
            subtitle: "ハンバーガー,ワイン,ダイニングバー,アメリカ料理",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 35.666565840656, longitude: 139.73106709534))
        //mapView.addAnnotation(shop3)
        
        
        
        // google map
        var camera = GMSCameraPosition.cameraWithTarget(initialLocation.coordinate, zoom: 15.0)
        self.mapView.myLocationEnabled = true
        self.mapView.camera = camera
        self.mapView.delegate = self
        //self.gmsMapView.settings.rotateGestures = false
        self.mapView.settings.compassButton = true
        self.mapView.settings.myLocationButton = true
        self.mapView.settings.indoorPicker = true
        
        var marker = GMSMarker()
        marker.position = initialLocation.coordinate
        marker.title = "ミッドタウン"
        marker.snippet = "Tokyo"
        marker.map = self.mapView
        
        var path = GMSMutablePath()
        path.addCoordinate(CLLocationCoordinate2DMake(35.6666973, 139.730563))
        path.addCoordinate(CLLocationCoordinate2DMake(35.652301, 139.749945))
        var polyline = GMSPolyline(path: path)
        polyline.map = self.mapView

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
/*
    func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 500
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    /* MKMapViewDelegate */
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Shop {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                    dequeuedView.annotation = annotation
                    view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as! UIView
            }
            return view
        }
        return nil
    }
*/
    
    /* GMSMapViewDelegate */
    func mapView(mapView: GMSMapView!, didTapAtCoordinate coordinate: CLLocationCoordinate2D) {
        println("You tapped at \(coordinate.latitude),\(coordinate.longitude)")
    }
    
    func mapView(mapView: GMSMapView!, willMove gesture: Bool) {
        //println("willMove")
    }
    
    func mapView(mapView: GMSMapView!, didChangeCameraPosition position: GMSCameraPosition!) {
        //println("didChangeCameraPosition")
    }
    
    func mapView(mapView: GMSMapView!, idleAtCameraPosition position: GMSCameraPosition!) {
        //println("idleAtCameraPosition")
    }

}

