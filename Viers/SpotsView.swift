//
//  SpotsView.swift
//  Viers
//
//  Created by Kun  on 14/12/22.
//

import SwiftUI

struct SpotsView: View {
    @EnvironmentObject var viewModel: ViewModel
    @State var addName: String = ""
    @State var addCrowd: String = ""
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.spots, id: \.id) { spot in
                    let intCrowd = Float(spot.crowd) ?? 0.0
                    HStack {
                        Text(spot.name)
                        Spacer()
                        ProgressView(value: intCrowd/100)
                    }
                }
                
                HStack {
                    TextField("Name", text:$addName)
                    Spacer()
                    TextField("Crowd (in %)", text:$addCrowd)
                }
                
                Button("Add New Spot") {
                    viewModel.addSpots(newSpot: Spots(name: addName, crowd: addCrowd))
                    
                }
            }
            .navigationTitle("Spots List")
        }
    }
}
