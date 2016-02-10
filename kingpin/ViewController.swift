//
//  ViewController.swift
//  kingpin
//
//  Created by Sheraz Mahmood on 2/9/16.
//  Copyright © 2016 smahmood. All rights reserved.
//

import UIKit
import MapKit
import MapKit.MKAnnotation

class ViewController: UIViewController {

  @IBOutlet weak var mapView: MKMapView!
  private var clusteringController : KPClusteringController!
  
  let dataSource = [
    CLLocationCoordinate2D(latitude: 38.9809754923239, longitude: 1.2963763101744),
    CLLocationCoordinate2D(latitude: 39.5541634, longitude: -104.8817607),
    CLLocationCoordinate2D(latitude: 32.8121905400919, longitude: -96.7622954649535),
    CLLocationCoordinate2D(latitude: 30.2584147, longitude: -97.7876984),
    CLLocationCoordinate2D(latitude: 12.5682396, longitude: -70.0487281),
    CLLocationCoordinate2D(latitude: 43.0764243, longitude: -70.7523988),
    CLLocationCoordinate2D(latitude: 21.6777317335946, longitude: -158.037047248583),
    CLLocationCoordinate2D(latitude: 30.249266, longitude: -97.7688081),
    CLLocationCoordinate2D(latitude: 43.090455190873, longitude: -70.735845703533),
    CLLocationCoordinate2D(latitude: 38.9676790596944, longitude: -77.3963610955552),
    CLLocationCoordinate2D(latitude: 38.3014454053836, longitude: -122.281989978389),
    CLLocationCoordinate2D(latitude: 30.2523012, longitude: -97.7483054),
    CLLocationCoordinate2D(latitude: 38.4067822710285, longitude: -122.366841740955),
    CLLocationCoordinate2D(latitude: 43.0770026218223, longitude: -70.7574871067973),
    CLLocationCoordinate2D(latitude: 30.2804408, longitude: -97.7591677),
    CLLocationCoordinate2D(latitude: 30.2780903, longitude: -97.7716979),
    CLLocationCoordinate2D(latitude: 21.5911290510704, longitude: -158.102851008855),
    CLLocationCoordinate2D(latitude: 40.7206057172819, longitude: -73.9844524730023),
    CLLocationCoordinate2D(latitude: -33.8429952, longitude: 151.2413223),
    CLLocationCoordinate2D(latitude: 30.2801029913591, longitude: -97.7436863299742),
    CLLocationCoordinate2D(latitude: 10.2995034668516, longitude: -85.8415807673024),
    CLLocationCoordinate2D(latitude: 38.951561, longitude: -77.4093062),
    CLLocationCoordinate2D(latitude: 30.2695180720372, longitude: -97.7456761316609),
    CLLocationCoordinate2D(latitude: 34.039139291663, longitude: -118.442525156773),
    CLLocationCoordinate2D(latitude: 34.1041327274908, longitude: -118.272816967724),
    CLLocationCoordinate2D(latitude: 40.7217210821789, longitude: -73.988533056247),
    CLLocationCoordinate2D(latitude: 32.8395828426608, longitude: -96.6967348822755),
    CLLocationCoordinate2D(latitude: 38.2974954756617, longitude: -122.288779427707),
    CLLocationCoordinate2D(latitude: 41.8836074271995, longitude: -87.6486888892763),
    CLLocationCoordinate2D(latitude: 32.7480300607296, longitude: -96.828750150173),
    CLLocationCoordinate2D(latitude: 37.7638794555336, longitude: -122.46897737343),
    CLLocationCoordinate2D(latitude: 39.6895693, longitude: -104.9806234),
    CLLocationCoordinate2D(latitude: 38.3206471068681, longitude: -122.29877338046),
    CLLocationCoordinate2D(latitude: 30.237152, longitude: -97.7494097),
    CLLocationCoordinate2D(latitude: 32.7278984893233, longitude: -117.169727071008),
    CLLocationCoordinate2D(latitude: 30.2473066566584, longitude: -97.7507648555274),
    CLLocationCoordinate2D(latitude: 42.5471692473749, longitude: -70.9456838227943),
    CLLocationCoordinate2D(latitude: 33.6754477070958, longitude: -117.663061162566),
    CLLocationCoordinate2D(latitude: 32.8204615655031, longitude: -96.7845830514444),
    CLLocationCoordinate2D(latitude: 39.932242, longitude: -75.147567),
    CLLocationCoordinate2D(latitude: 41.8846784, longitude: -87.6228175),
    CLLocationCoordinate2D(latitude: 40.745629, longitude: -73.9937463),
    CLLocationCoordinate2D(latitude: 38.301814763618, longitude: -122.281743275283),
    CLLocationCoordinate2D(latitude: 38.1792532636769, longitude: -120.381342684457),
    CLLocationCoordinate2D(latitude: 39.6896966, longitude: -104.9806228),
    CLLocationCoordinate2D(latitude: 38.2984805318105, longitude: -122.286691420309),
    CLLocationCoordinate2D(latitude: 30.2644340517885, longitude: -97.7278237523933),
    CLLocationCoordinate2D(latitude: 41.9102937, longitude: -87.6760621),
    CLLocationCoordinate2D(latitude: 30.2690110424414, longitude: -97.7478169463432),
    CLLocationCoordinate2D(latitude: 10.2986054, longitude: -85.8428123),
    CLLocationCoordinate2D(latitude: 51.51732, longitude: -0.063029),
    CLLocationCoordinate2D(latitude: 33.7621996677519, longitude: -84.3887655005406),
    CLLocationCoordinate2D(latitude: 37.8007324, longitude: -122.4079689),
    CLLocationCoordinate2D(latitude: 39.5428284601846, longitude: -104.941646679035),
    CLLocationCoordinate2D(latitude: 36.3727801904557, longitude: -94.2089939232761),
    CLLocationCoordinate2D(latitude: 37.7873781850488, longitude: -122.433449070908),
    CLLocationCoordinate2D(latitude: 43.0713775611794, longitude: -70.7707891788525),
    CLLocationCoordinate2D(latitude: 40.7643814807589, longitude: -73.9876452000322),
    CLLocationCoordinate2D(latitude: 38.9807694527709, longitude: 1.29620954660009),
    CLLocationCoordinate2D(latitude: 40.7302912, longitude: -73.9835616),
    CLLocationCoordinate2D(latitude: -33.4239815045741, longitude: -70.6167095413876),
    CLLocationCoordinate2D(latitude: -34.5814475919762, longitude: -58.431877557276),
    CLLocationCoordinate2D(latitude: 40.7164829865417, longitude: -73.9558675267642),
    CLLocationCoordinate2D(latitude: 29.7427055817669, longitude: -95.4103860726789),
    CLLocationCoordinate2D(latitude: 37.7973164386001, longitude: -122.406127266963),
    CLLocationCoordinate2D(latitude: 30.2803103232201, longitude: -97.7595416512188),
    CLLocationCoordinate2D(latitude: 30.2501544952393, longitude: -97.7546844482422),
    CLLocationCoordinate2D(latitude: 40.861609363887, longitude: -73.8983337864546),
    CLLocationCoordinate2D(latitude: 30.3293896, longitude: -97.7402512),
    CLLocationCoordinate2D(latitude: 30.2498056, longitude: -97.754687),
    CLLocationCoordinate2D(latitude: 36.373826347279, longitude: -94.2090339451151),
    CLLocationCoordinate2D(latitude: 42.3512254, longitude: -71.0644009),
    CLLocationCoordinate2D(latitude: 42.3218384, longitude: -83.0716133),
    CLLocationCoordinate2D(latitude: 41.8846684, longitude: -87.6476489),
    CLLocationCoordinate2D(latitude: 37.7652609, longitude: -122.4499719),
    CLLocationCoordinate2D(latitude: 41.9760684, longitude: -87.6688893),
    CLLocationCoordinate2D(latitude: 38.9678795204477, longitude: -77.3726170284419),
    CLLocationCoordinate2D(latitude: 30.2600133, longitude: -97.7385023),
    CLLocationCoordinate2D(latitude: 30.2443506371651, longitude: -97.7580200093093),
    CLLocationCoordinate2D(latitude: 40.7309410074273, longitude: -74.0041311023894),
    CLLocationCoordinate2D(latitude: 30.2638237, longitude: -97.7632926),
    CLLocationCoordinate2D(latitude: 39.9487324693092, longitude: -75.1435230015039),
    CLLocationCoordinate2D(latitude: 41.9740163, longitude: -87.6551598),
    CLLocationCoordinate2D(latitude: 37.7997484, longitude: -122.4079134),
    CLLocationCoordinate2D(latitude: 34.0630614, longitude: -118.4468781),
    CLLocationCoordinate2D(latitude: 41.8894077944997, longitude: -87.6338893614396),
    CLLocationCoordinate2D(latitude: 37.75642, longitude: -122.419137),
    CLLocationCoordinate2D(latitude: 41.8866719, longitude: -87.64889),
    CLLocationCoordinate2D(latitude: 39.5495139, longitude: -105.0011499),
    CLLocationCoordinate2D(latitude: 39.7512211, longitude: -105.002115),
    CLLocationCoordinate2D(latitude: 40.7528195740561, longitude: -73.983605983022),
    CLLocationCoordinate2D(latitude: 37.7645424765971, longitude: -122.466669632821),
    CLLocationCoordinate2D(latitude: 42.3424145, longitude: -71.1218629),
    CLLocationCoordinate2D(latitude: 30.2700124540869, longitude: -97.7484746430681),
    CLLocationCoordinate2D(latitude: 22.2044120757044, longitude: -159.491726569144),
    CLLocationCoordinate2D(latitude: 30.2550216, longitude: -97.7618499),
    CLLocationCoordinate2D(latitude: 42.5460799330949, longitude: -83.2151490391417),
    CLLocationCoordinate2D(latitude: 30.2499704, longitude: -97.7500381),
    CLLocationCoordinate2D(latitude: 35.4806402313387, longitude: -97.520852106203),
    CLLocationCoordinate2D(latitude: 41.8846280718583, longitude: -87.6300213662489),
    CLLocationCoordinate2D(latitude: 39.9495782180273, longitude: -75.1621663317759),
    CLLocationCoordinate2D(latitude: 41.883663, longitude: -87.6489878),
    CLLocationCoordinate2D(latitude: 21.587013107046, longitude: -158.10304287258),
    CLLocationCoordinate2D(latitude: 32.8394285204218, longitude: -96.6966864422677),
    CLLocationCoordinate2D(latitude: 32.7273995057126, longitude: -117.170863790403),
    CLLocationCoordinate2D(latitude: 34.0111279993518, longitude: -118.816597504566),
    CLLocationCoordinate2D(latitude: 30.2508227, longitude: -97.7542645),
    CLLocationCoordinate2D(latitude: 30.273270859949, longitude: -97.7571405949054),
    CLLocationCoordinate2D(latitude: 30.2797552726524, longitude: -97.7436575925381),
    CLLocationCoordinate2D(latitude: 41.8874171597223, longitude: -87.6731214279928),
    CLLocationCoordinate2D(latitude: 40.7205783436524, longitude: -73.9872323139749),
    CLLocationCoordinate2D(latitude: 39.7979807585213, longitude: -89.6475750034178),
    CLLocationCoordinate2D(latitude: 32.8199168589354, longitude: -96.8020737624504),
    CLLocationCoordinate2D(latitude: 33.6552477095686, longitude: -117.777838956651),
    CLLocationCoordinate2D(latitude: 47.624061, longitude: -122.3367612),
    CLLocationCoordinate2D(latitude: 30.2496642, longitude: -97.7499575)
  ]
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupClusteringAlgorithm()
  }

  func loadCoordinateData() {
    var places: [KPAnnotation] = []
    for item in dataSource {
      let annotation = KPAnnotation()
      annotation.coordinate = item
      places.append(annotation)
    }
    self.clusteringController.setAnnotations(places)
  }

  func setupClusteringAlgorithm() {
    //Setup the clustering Map view
    let algorithm : KPGridClusteringAlgorithm = KPGridClusteringAlgorithm()
    
    algorithm.annotationSize = CGSizeMake(50, 50)
    algorithm.clusteringStrategy = KPGridClusteringAlgorithmStrategy.TwoPhase;
    
    clusteringController = KPClusteringController(mapView: self.mapView, clusteringAlgorithm: algorithm)
    clusteringController.delegate = self
  }
  
  @IBAction func loadDataTouchUpInside(sender: AnyObject) {
    loadCoordinateData()
  }
  @IBAction func allDataDoesNotLoadTouchUpInside(sender: AnyObject) {
    let centerOnPoint:CLLocationCoordinate2D! = CLLocationCoordinate2D(latitude: 20.75028, longitude: -156.5028)
    let region = MKCoordinateRegionMake(centerOnPoint, mapView.region.span)
    mapView.setRegion(region, animated: true)
    
  }

  @IBAction func dataLoadsCorrectlyTouchUpInside(sender: AnyObject) {
    let centerOnPoint:CLLocationCoordinate2D! = CLLocationCoordinate2D(latitude: 30.26715, longitude: -97.74306)
    let region = MKCoordinateRegionMake(centerOnPoint, mapView.region.span)
    mapView.setRegion(region, animated: true)
    
  }
}

extension ViewController: KPClusteringControllerDelegate {
  func clusteringController(clusteringController: KPClusteringController!, configureAnnotationForDisplay annotation: KPAnnotation!) {
    annotation.title = "\(annotation.annotations.count)"
  }
}
