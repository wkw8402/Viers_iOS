//
//  ViersApp.swift
//  Viers
//
//  Created by Kun  on 14/12/22.
//

import SwiftUI
import Firebase

@main
struct ViersApp: App {
    
    init() {
        FirebaseApp.configure()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 13/225, green: 71/255, blue:161/255, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor: UIColor.white]
    }
    
    @StateObject var viewModel: ViewModel = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
