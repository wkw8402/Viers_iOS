//
//  ViewModel.swift
//  Viers
//
//  Created by Kun  on 14/12/22.
//

import SwiftUI
import Firebase

class ViewModel: ObservableObject {
    @Published var userIsLoggedIn: Bool
    @Published var spots: [Spots]
    
    init() {
        self.userIsLoggedIn = false
        self.spots = [Spots]()
    }
    
    // Registers a user.
    func register(email: String, password: String) {
        // Add any password or username constraints here.
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            // Begin Completion Handler
            if let err = error {
                // Error exists.
                print(err.localizedDescription)
                return
            }
            
            // At this point the user has successfully registered. Can do anything you want here after the user has registered.
            
            // Use this if you want to get the user's id to create a db entry for the user's data.
            // var userID = result?.user.uid ?? ""
        }
    }
    
    // Logs in a user
    func login(email: String, password: String) {
        // Log the user in with Firebase.
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            // Begin Completion Handler
            if let err = error {
                // Error exists, could not sign the user in. (Alternatively, could trigger an alert from here.)
                print(err.localizedDescription)
                return
            }
            
            // At this point, the user has successfully logged in. Load user's data.
            self.userIsLoggedIn = true
            self.fetchspots()
            
            // Use this if you want to get the user's id to fetch the user's data from the db.
            // var userID = result?.user.uid ?? ""
        }
    }
    
    // Signs the user out.
    func signOut() {
        // Only log the user out if they are logged in.
        if (!self.userIsLoggedIn) {
            print("No user logged in.")
            return
        }
        
        // Wrap inside a do block to catch errors.
        do {
            try Auth.auth().signOut()
            self.userIsLoggedIn = false
        // Catch error instead of crashing if log out fails.
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    // Get spots spots
    func fetchspots() {
        // Clear the spots because we will fill it up with the spots from the database.
        spots.removeAll()
        
        let db = Firestore.firestore()
        let ref = db.collection("spots")
        ref.getDocuments { snapshot, error in
            // Begin Completion Handler
            if let err = error {
                // Error exists.
                print(err.localizedDescription)
                return
            }
            
            // Check if documents exist in the database.
            if let snap = snapshot {
                // Loop over each document in the spots collection.
                for doc in snap.documents {
                    // Retreive the document data.
                    let data = doc.data()
                    // Get data about the spot.
                    let id = data["id"] as? String ?? ""
                    let name = data["name"] as? String ?? ""
                    let crowd = data["crowd"] as? String ?? ""
                    guard let timestamp = data["date"] as? Timestamp else {
                        return
                    }
                    let date = timestamp.dateValue()
                            
                    // Add the spot to the spots.
                    let spot = Spots(id: id, name: name, crowd: crowd, date: date)
                    self.spots.append(spot)
                }
            }
        }
    }
    
    // Add an spot to the spots
    func addSpots(newSpot: Spots) {
        let db = Firestore.firestore()
        
        // Specify the document with its id that you want to add or modify.
        let ref = db.collection("spots").document(newSpot.name)
        
        // Add or modify the document to the database.
        ref.setData(["name": newSpot.name, "crowd": newSpot.crowd, "id": newSpot.id, "date": newSpot.date])
        
        // Add the spot to the spots.
        self.spots.append(newSpot)
    }
}
