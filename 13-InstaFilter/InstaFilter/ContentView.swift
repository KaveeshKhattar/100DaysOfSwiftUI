//
//  ContentView.swift
//  InstaFilter
//
//  Created by Kaveesh Khattar on 23/06/22.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    @State private var filterIntensity = 0.5
    @State private var showingImagePicker = false
    
    func loadImage(){
        guard let inputImage = inputImage else {
            return
        }
        
        image = Image(uiImage: inputImage)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                
                HStack{
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                .padding(.vertical)
                
                HStack{
                    Button("Change Filter"){
                        // change filter
                    }
                    
                    Spacer()
                    
                    Button("Save"){
                        // save the picture
                    }
                }
            }
            .padding(([.horizontal, .bottom]))
            .navigationTitle("Instafilter")
            .sheet(isPresented: $showingImagePicker){
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in loadImage() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
