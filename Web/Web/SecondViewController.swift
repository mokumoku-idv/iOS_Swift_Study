//
//  SecondViewController.swift
//  Web
//
//  Created by pomn on 4/15/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mapView.delegate = self
        
        
        let initialLocation = CLLocation(latitude: 35.6666973, longitude: 139.730563)
        
        centerMapOnLocation(initialLocation)
        
        let shop1 = Shop(title: "オービカ モッツァレラバー 東京ミッドタウン店",
            subtitle: "BAR・ラウンジ",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 35.6666973, longitude: 139.730563))
        mapView.addAnnotation(shop1)
        
        let shop2 = Shop(title: "東京ミッドタウン　東京ミッドタウン・ホールＡ",
            subtitle: "ホール・劇場",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 35.665168773482, longitude: 139.73121491527))
        mapView.addAnnotation(shop2)
        
        let shop3 = Shop(title: "ROTI 東京ミッドタウン",
            subtitle: "ハンバーガー,ワイン,ダイニングバー,アメリカ料理",
            discipline: "Sculpture",
            coordinate: CLLocationCoordinate2D(latitude: 35.666565840656, longitude: 139.73106709534))
        mapView.addAnnotation(shop3)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
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


}

