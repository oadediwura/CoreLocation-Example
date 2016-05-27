//
//  ViewController.swift
//  location_tracker
//
//  Created by User on 5/26/16.
//  Copyright © 2016 User. All rights reserved.
//

import UIKit

import CoreLocation

import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var TheMap: MKMapView!
    
    @IBOutlet weak var theLabel: UILabel!
    
    var manager:CLLocationManager!
    
    var myLocations: [CLLocation] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Setup our Location Manager
        
        manager = CLLocationManager()
        
        manager.delegate = self
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        
        manager.requestAlwaysAuthorization()
        
        manager.startUpdatingLocation()
        
        //Setup our Map View
        
        TheMap.delegate = self
        
        TheMap.mapType = MKMapType.Hybrid
        
        TheMap.showsUserLocation = true
        
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
    
        
        myLocations.append(locations[0] )
        
        let spanX = 0.007
        
        let spanY = 0.007
        
        let newRegion = MKCoordinateRegion(center: TheMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        
        TheMap.setRegion(newRegion, animated: true)
        
        if (myLocations.count > 1){
            
            let sourceIndex = myLocations.count - 1
            
            let destinationIndex = myLocations.count - 2
            
            let c1 = myLocations[sourceIndex].coordinate
            
            let c2 = myLocations[destinationIndex].coordinate
            
            var a = [c1, c2]
            
            let polyline = MKPolyline(coordinates: &a, count: a.count)
            
            TheMap.addOverlay(polyline)
            
        }
        
    }
    
    //func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    
    //if overlay is MKPolyline {
    
    //let polylineRenderer = MKPolylineRenderer(overlay: overlay)
    
    //polylineRenderer.strokeColor = UIColor.blueColor()
    
    //polylineRenderer.lineWidth = 4
    
    //return polylineRenderer
    
    //}
    
    //return
    
    //}
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
        
    }
    
}
    
   