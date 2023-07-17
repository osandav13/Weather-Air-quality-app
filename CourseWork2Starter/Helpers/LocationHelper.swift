//
//  LocationHelper.swift
//  Coursework2
//
//  Created by G Lukka.
//

import Foundation

import CoreLocation
func getLocFromLatLong(lat: Double, lon: Double) async -> String
{
    var locationString: String
    var placemarks: [CLPlacemark]
    let center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
    
    let ceo: CLGeocoder = CLGeocoder()
    // converting latitude and longitude to a location
    let location: CLLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    do {
        //reversing the location data to find
        placemarks = try await ceo.reverseGeocodeLocation(location)
        // making the location string depending on the availible data
        if placemarks.count > 0 {
            
            if (!placemarks[0].name!.isEmpty) {
                
                locationString = "\(placemarks[0].name!), \n \(placemarks[0].locality!),\(placemarks[0].country!)"
                
            } else {
                locationString = (placemarks[0].locality ?? "No City")
            }
            
            return locationString
        }
    } catch {
        print("Reverse geodecoe fail: \(error.localizedDescription)")
        locationString = "No City, No Country"
       
        return locationString
    }
    
    return "Error getting Location"
}
