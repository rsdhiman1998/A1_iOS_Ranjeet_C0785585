//
//  ViewController.swift
//  A1_iOS_Ranjeet_C0785585
//
//  Created by Ranjeet Singh on 25/01/21.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapVIew: MKMapView!
    var places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let latitude: CLLocationDegrees = 43.64
        let longitude: CLLocationDegrees = -79.38
       
        displayLoc(latitude: latitude, longitude: longitude, title: "Brampton B-Town", subtitle: "You are in B-town")
        let lgpress = UILongPressGestureRecognizer(target: self, action: #selector(addLongPress))
        mapVIew.addGestureRecognizer(lgpress)
        mapVIew.delegate = self
      //  doubleTapping()
      //  line()
    }
    func line()
    {
        let coordinates = places.map {$0.coordinate}
        let line = MKPolyline(coordinates: coordinates, count: coordinates.count)
        mapVIew.addOverlay(line)
    }
    

    func doubleTapping()
    {
        let rd = UITapGestureRecognizer(target: self, action: #selector(dropping_pin))
        rd.numberOfTouchesRequired = 2
        mapVIew.addGestureRecognizer(rd)
        
    }
    @objc func dropping_pin(sender : UITapGestureRecognizer)
    {
       // removepinloc()
        let ts = sender.location(in: mapVIew)
        let cr = mapVIew.convert(ts, toCoordinateFrom: mapVIew)
        let annotation = MKPointAnnotation()
        annotation.title = "My destination"
        annotation.coordinate = cr
        mapVIew.addAnnotation(annotation)
        
        
    }
    
    func removepinloc()
    {
        for annotation in mapVIew.annotations
        {
            mapVIew.removeAnnotation(annotation)
        }
    }
    var c = 1
    @objc func addLongPress(gestureRecognizer: UIGestureRecognizer)
    {
        let touchPoint = gestureRecognizer.location(in: mapVIew)
        let coordinate = mapVIew.convert(touchPoint, toCoordinateFrom: mapVIew)
        
        // Adding the annotation for that
        let annotation = MKPointAnnotation()
        
       // print(c)
        if c == 1
        {
        annotation.title = "A"
        annotation.coordinate = coordinate
        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
            c += 1
    }
        if c == 2
        {
        annotation.title = "B"
        annotation.coordinate = coordinate
        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
            c += 1
    }
        if c == 3
        {
        annotation.title = "C"
        annotation.coordinate = coordinate
        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
            c += 1
    }
        if c == 4
        {
           // mapVIew.removeAnnotations(mapVIew.annotations)
         //   mapVIew.removeOverlays(mapVIew.overlays)
         //   places.removeAll()
            c = 1
                        
    }
    
    }
        //Mark: - display user
        func displayLoc(latitude: CLLocationDegrees,
                             longitude: CLLocationDegrees,
                             title: String,
                             subtitle: String)
        {
            let latDelta: CLLocationDegrees = 0.05
            let langDelta: CLLocationDegrees = 0.05
            
            
            let span = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: langDelta)
            
            let loc = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            
            let region = MKCoordinateRegion(center: loc, span: span)
            
            mapVIew.setRegion(region, animated: true)
     
            let annotation = MKPointAnnotation()
            annotation.title = title
            annotation.subtitle = subtitle
            annotation.coordinate = loc
           // mapVIew.addAnnotation(annotation)
        
        
        
        }
        
}


extension ViewController: MKMapViewDelegate
{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        if overlay is MKPolyline
        {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 3
            return renderer
        }
        return MKOverlayRenderer()
    }
}
