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
                                .frame(width: CGFloat(100))
                            Spacer()
                            let intCrowd = Float(spot.crowd) ?? 0.0
                            ProgressView(value: intCrowd/100)
                        }
                        
                        HStack {
                            Text(spot.date, style: .date)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(spot.date, style: .time)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                HStack {
                    TextField("Name", text:$addName)
                    Spacer()
                    TextField("Crowd (in %)", text:$addCrowd)
                }
                
                Button("Add New Spot") {
                    viewModel.addSpots(newSpot: Spots(name: addName, crowd: addCrowd, date: addDate))
                }
                Button("Update the Spot") {
                    viewModel.fixSpots(changedSpot: Spots(name: addName, crowd: addCrowd, date: addDate))
                }
            }
            .navigationTitle("Spots List")
        }
    }
}
