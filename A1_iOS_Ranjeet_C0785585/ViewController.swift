//
//  ViewController.swift
//  A1_iOS_Ranjeet_C0785585
//
//  Created by Ranjeet Singh on 25/01/21.
//

import UIKit
import MapKit
class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var label_a: UILabel!
    @IBOutlet weak var mapVIew: MKMapView!
    var places = Place.getPlaces()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let latitude: CLLocationDegrees = 43.64
        let longitude: CLLocationDegrees = -79.38
       
        displayLoc(latitude: latitude, longitude: longitude, title: "My Location", subtitle: "You are in B-town")
        let lgpress = UITapGestureRecognizer(target: self, action: #selector(addLongPress)); mapVIew.addGestureRecognizer(lgpress)
            mapVIew.delegate = self
      //  doubleTapping()
      line()
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
        mapVIew.addAnnotation(annotation)
        
    
    
    
    }
    func addPolygon() {
        let coordinates = places.map {$0.coordinate}
      let polygon = MKPolygon(coordinates: coordinates, count: coordinates.count)
          self.polygon = polygon
        mapVIew.addOverlay(polygon)
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
    
    @objc func deletePointer(_sender: AnyObject?) {
        let dd = _sender?.tag
        var d = Int(dd!)
        print(d)
        if(places.count >= d)
        {
            places.remove(at: d)
            mapVIew.removeAnnotation(mapVIew.annotations[d])
        }
        
        
        
    }
    
    

    var c = 2
    var d = 1
    @objc func addLongPress(gestureRecognizer: UIGestureRecognizer)
    {
        let touchPoint = gestureRecognizer.location(in: mapVIew)
        let coordinate = mapVIew.convert(touchPoint, toCoordinateFrom: mapVIew)
        let latitud: CLLocationDegrees = 43.64
        let longitud: CLLocationDegrees = -79.38
        let coordinate0 = CLLocation(latitude: latitud, longitude: longitud)
        var index = 0
        var locString  = ""
        
//
//            let checkLat = lat
//            let checkLong = long

        let coordinate1 = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

            let distanceInMeters = coordinate0.distance(from: coordinate1)
            let km = distanceInMeters / 1000.0
            let dou =  Double(distanceInMeters)
            if(index <= 2)
            {
            locString = String(format:"%.2f",dou)+" km"
            }
     
        // Adding the annotation for that
        let annotation = MKPointAnnotation()
        
//        print(c)
       // print(c)
        if c == 2
        {
        annotation.title = "A"
        annotation.coordinate = coordinate
            annotation.subtitle = locString
        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
            c += 1
            
           
    }
       else if c == 3
        {
        annotation.title = "B"
        annotation.coordinate = coordinate
        annotation.subtitle = locString;        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
            c += 1
    }
       else if c == 4
        {
        annotation.title = "C"
        annotation.coordinate = coordinate
        annotation.subtitle = locString
        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
        places.append(places[0])
            c += 1
    }
      else  if c == 5
        {
            mapVIew.removeAnnotations(mapVIew.annotations)
            mapVIew.removeOverlays(mapVIew.overlays)
            places.removeAll()
        let latitude: CLLocationDegrees = 43.64
        let longitude: CLLocationDegrees = -79.38
       
        displayLoc(latitude: latitude, longitude: longitude, title: "My Location", subtitle: "You are in B-town")
        
        annotation.title = "A"
        annotation.coordinate = coordinate
        places.append(Place(title:annotation.title, subtitle: annotation.subtitle, coordinate:annotation.coordinate))
        mapVIew.addAnnotation(annotation)
        c=2
            c += 1
                        
    }
        
        line()
        addPolygon()
       
    
    }
    
    

    @IBOutlet weak var routeButton: UIButton!
    @IBAction func route_draw(_ sender: UIButton) {
        mapVIew.removeOverlays(mapVIew.overlays)
        print(places.count)
        if(places.count >= 3)
        {
            getDistance(cor1: places[0],cor2: places[1])
            getDistance(cor1: places[1],cor2: places[2])
            getDistance(cor1: places[2],cor2: places[0])
        }
      /*      else if(places.count <= 2)
        {
        getDistance(cor1: places[0],cor2: places[1])
        getDistance(cor1: places[1],cor2: places[2])
        }
        else if(places.count <= 1)
        {
        getDistance(cor1: places[0],cor2: places[1])

            }*/

            }

    func getDistance(cor1:Place,cor2:Place)
        {
            
          
            

        let sourcePlaceMark = MKPlacemark(coordinate: cor1.coordinate)

        let destinationPlaceMark = MKPlacemark(coordinate: cor2.coordinate)

            // request a direction

            let directionRequest = MKDirections.Request()

            

            // assign the source and destination properties of the request

            directionRequest.source = MKMapItem(placemark: sourcePlaceMark)

            directionRequest.destination = MKMapItem(placemark: destinationPlaceMark)

        
            // transportation type

            directionRequest.transportType = .automobile

            

            // calculate the direction

            let directions = MKDirections(request: directionRequest)

            directions.calculate { (response, error) in

                guard let directionResponse = response else {return}

                // create the route

                let route = directionResponse.routes[0]

                // drawing a polyline
                
                

                self.mapVIew.addOverlay(route.polyline, level: .aboveRoads)
             
                
                

                // define the bounding map rect

                let rect = route.polyline.boundingMapRect

                self.mapVIew.setVisibleMapRect(rect, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
            
               
                
        }
    
    
    

    }
    fileprivate var polygon: MKPolygon? = nil

 
}


extension ViewController: MKMapViewDelegate
{
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?
//      {
//          let annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationView")
//          annotationView.canShowCallout = true
//        annotationView.rightCalloutAccessoryView = UIButton.init(type: UIButton.ButtonType.close)
//
//          return annotationView
//      }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // this is our unique identifier for view reuse
        let identifier = "Placemark"

        // attempt to find a cell we can recycle
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            
            // we didn't find one; make a new one
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)

            // allow this to show pop up information
            annotationView?.canShowCallout = true
            annotationView?.isSelected = true
            
let ui = UILabel()
            ui.text = (annotationView?.annotation?.subtitle)!
            // attach an information button to the view
            annotationView?.rightCalloutAccessoryView = ui

        } else {
            // we have a view to reuse, so give it the new annotation
            annotationView?.annotation = annotation


        }
        annotationView?.annotation = annotation
        // whether it's a new view or a recycled one, send it back
        return annotationView
    }
  
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer
    {
        if overlay is MKPolyline
        {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = UIColor.green
            renderer.fillColor = UIColor.green
            
            renderer.lineWidth = 3
            return renderer
        }
        else {
            let renderer = MKPolygonRenderer(polygon: polygon!)
                    renderer.fillColor = UIColor.red.withAlphaComponent(0.5)
                    return renderer
                }
        return MKOverlayRenderer(overlay: overlay)
    }
}
