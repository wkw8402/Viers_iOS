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
    @State var addDate: Date = Date.now
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.spots, id: \.id) { spot in
                    VStack {
                        HStack {
                            Text(spot.name)
                            Spacer()
                            let intCrowd = Float(spot.crowd) ?? 0.0
                            ProgressView(value: intCrowd/100)
                        }
                        Text(spot.date, style: .time)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                
                VStack {
                    TextField("Name", text:$addName)
                    Spacer()
                    TextField("Crowd (in %)", text:$addCrowd)
                    
                    HStack {
                        Button("Add") {
                            viewModel.addSpots(newSpot: Spots(name: addName, crowd: addCrowd, date: addDate))
                        }
                        Button("Fix") {
                            viewModel.updateSpots(fixedSpot: Spots(name: addName, crowd: addCrowd, date: addDate))
                        }
                    }
                }
            }
            .navigationTitle("Spots List")
        }
    }
}
