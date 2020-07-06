//
//  ContentView.swift
//  Panic Button - Core Location
//
//  Created by Vitor Hugo on 7/5/20.
//  Copyright © 2020 Vitor Hugo. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit

struct ContentView: View {
    
    @ObservedObject var locationManager = LocationManager()
    
    var userLatitude: CLLocationDegrees {
        return (locationManager.lastLocation?.coordinate.latitude ?? 0)
    }
    var userLongitude: CLLocationDegrees {
        return (locationManager.lastLocation?.coordinate.longitude ?? 0)
    }
    
    @State var long: CLLocationDegrees = 0
    @State var lat: CLLocationDegrees = 0
    
        
    var body: some View {
        VStack(alignment: .center) {
            
            MapView(mapLat: self.userLatitude, mapLong: self.userLongitude)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 300, alignment: .topLeading)
                .edgesIgnoringSafeArea(.top)

            Spacer()
            Text("Latitude: \(lat)")
            Text("Longitude: \(long)")
            Spacer()
            Button(action: {
                self.lat = self.userLatitude
                self.long = self.userLongitude
                
                self.updateLocation()
                
            }
            ){
                Text("Get Location")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .font(.title)
                .cornerRadius(20)
            }
            Spacer()
        }
    }
    
    func updateLocation() {
        //MapView.init(mapLat: self.userLatitude, mapLong: self.userLongitude)
            }
}

struct MapView: UIViewRepresentable {
    
    @State var mapLat: CLLocationDegrees
    @State var mapLong: CLLocationDegrees
    
    func makeUIView(context: Context) -> MKMapView{
         MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        
//        var updateLat: CLLocationDegrees
//        var updateLong: CLLocationDegrees
        
        // 1
        view.mapType = MKMapType.standard // (satellite)

        // 2
        let mylocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(mapLat),longitude: CLLocationDegrees(mapLong))

        // 3
        let coordinate = CLLocationCoordinate2D(
            latitude: CLLocationDegrees(mapLat), longitude: CLLocationDegrees(mapLong))
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)

        // 4
        let annotation = MKPointAnnotation()
        annotation.coordinate = mylocation

        annotation.title = "My Location"
        annotation.subtitle = "Visit us soon"
        view.addAnnotation(annotation)
        
        
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
