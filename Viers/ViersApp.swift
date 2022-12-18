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
        UINavigationBar.appearance().backgroundColor = UIColor(red: 2/225, green: 87/255, blue:122/255, alpha: 1.0)
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
