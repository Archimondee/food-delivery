//
//  LocationPickerViewController.swift
//  FoodDelivery
//
//  Created by Gilang Aditya Rahman on 27/03/23.
//

import MapKit
import UIKit

class LocationPickerViewController: UIViewController {
  @IBOutlet var mapView: MKMapView!

  var location: CLLocation?
  var completion: (CLLocationCoordinate2D, String?) -> Void = { _, _ in }

  var locationManager: CLLocationManager!

  override func viewDidLoad() {
    super.viewDidLoad()

    setup()
    setupLocationManager()
  }

  func setup() {
    mapView.showsUserLocation = false
    mapView.delegate = self
  }

  func setupLocationManager() {
    locationManager = CLLocationManager()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()
    locationManager.delegate = self
  }

  func zoomToLocation() {
    if let location = location {
      let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                latitudinalMeters: 2000,
                                                longitudinalMeters: 2000)
      mapView.setRegion(coordinateRegion, animated: true)
      mapView.removeAnnotations(mapView.annotations)

      let annotation = FDAnnotation(title: "My Location", subtitle: nil, coordinate: location.coordinate)

      mapView.addAnnotation(annotation)
    }
  }
}

extension UIViewController {
  func presentLocationPickerViewController(completion: @escaping (CLLocationCoordinate2D, String?) -> Void) {
    let viewController = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "LocationPicker") as! LocationPickerViewController
    viewController.completion = completion

    present(viewController, animated: true, completion: nil)
  }
}

// MARK: - CLLocationManagerDelegate

extension LocationPickerViewController: CLLocationManagerDelegate {
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      self.location = location
      zoomToLocation()
      manager.stopUpdatingLocation()
    }
  }
}

// MARK: - MKMapViewDelegate

extension LocationPickerViewController: MKMapViewDelegate {
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    let identifier = "hotelAnnotationId"
    var view: MKMarkerAnnotationView
    if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView {
      dequeuedView.annotation = annotation
      view = dequeuedView
    } else {
      view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
    }
    view.canShowCallout = true
    view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
    return view
  }

  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    if let annotation = view.annotation as? FDAnnotation, let location = location {
      let geocoder = CLGeocoder()

      geocoder.reverseGeocodeLocation(location) { [weak self] placemark, _ in
        guard let `self` = self else { return }

        let address = placemark?.first
        self.dismiss(animated: true) {
          
          self.completion(annotation.coordinate, address?.description)
        }
      }
    }
  }
}
