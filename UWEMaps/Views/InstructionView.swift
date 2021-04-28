//
//  InstructionView.swift
//  UWEMaps
//
//  Created by Tom Clifford on 24/04/2021.
//

import SwiftUI
import MapKit

struct InstructionView: View {
    
    let instruction: RouteInstruction
    let height: CGFloat
    
    var body: some View {
        ZStack
        {
            RoundedRectangle(cornerRadius: 25.0)
                .frame(height: height * 0.15)
                .foregroundColor(Color("NavViewInstructionBackgroundColour"))
                .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 5, y: 5)
            HStack
            {
                Image(systemName: instruction.InstructionSymbol)
                    .resizable()
                    .foregroundColor(Color("NavViewInstructionTextColour"))
                    .frame(width: height * 0.11, height: height * 0.11)
                Spacer()
                Text(instruction.InstructionText)
                    .foregroundColor(Color("NavViewInstructionTextColour"))
            }.padding(.horizontal)
        }.padding(.horizontal)
        
    }
    
}

struct InstructionView_Previews: PreviewProvider {
    static var previews: some View {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
        
        let instruction = RouteInstruction(start: CLLocationCoordinate2D(latitude: 51.500822, longitude: -2.550083), end: CLLocationCoordinate2D(latitude: 51.500842, longitude: -2.550657), next: CLLocationCoordinate2D(latitude: 51.500495, longitude: -2.551049))
        
            GeometryReader { geometry in
        ZStack
        {
            Map(coordinateRegion: .constant(region))
                .edgesIgnoringSafeArea(.all)
            InstructionView(instruction: instruction, height: geometry.size.height)
        }
            }
        .previewDevice("iPhone 11")
        .previewDisplayName("iPhone 11")
        //        InstructionView()
        //            .previewDevice("iPhone 11 Pro")
        //            .previewDevice("iPhone 11 Pro")
        //        InstructionView()
        //            .previewDevice("iPhone 11 Pro Max")
        //            .previewDevice("iPhone 11 Pro Max")
        //        InstructionView()
        //            .previewDevice("iPhone 12 mini")
        //            .previewDevice("iPhone 12 mini")
        //        InstructionView()
        //            .previewDevice("iPhone 12 Pro Max")
        //.previewDevice("iPhone 12 Pro Max")
        GeometryReader { geometry in
        ZStack
        {
            Map(coordinateRegion: .constant(region))
                .edgesIgnoringSafeArea(.all)
            InstructionView(instruction: instruction, height: geometry.size.height)
        }
        }
        .previewDevice("iPhone SE (2nd generation)")
        .previewDisplayName("iPhone SE (2nd generation)")
    }
}
