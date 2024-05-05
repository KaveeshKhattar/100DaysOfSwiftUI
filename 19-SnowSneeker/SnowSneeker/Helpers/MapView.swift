//
//  MapView.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    
    var resort: Resort
    @State private var region = MKCoordinateRegion()
    
    func setRegion(_ coordinates: CLLocationCoordinate2D){
        region = MKCoordinateRegion(center: coordinates, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear{
                setRegion(resort.locationCoordinates)
            }
    }
}

struct MapView_Previews: PreviewProvider {
    
    static var resorts = ModelData().resorts
    
    static var previews: some View {
        MapView(resort: resorts[3])
            .environmentObject(ModelData())
    }
}
