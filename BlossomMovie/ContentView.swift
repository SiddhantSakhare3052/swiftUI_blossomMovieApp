//
//  ContentView.swift
//  BlossomMovie
//
//  Created by Siddhant Sakhare on 13/05/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab(Constants.homeString, systemImage: Constants.homeIconString) {
                HomeView()
            }
            Tab(Constants.upcomingString, systemImage: Constants.upcomingIconString) {
                Text(Constants.upcomingString)
            }
            Tab(Constants.searchString, systemImage: Constants.searchIconString) {
                Text(Constants.searchString)
            }
            Tab(Constants.downloadsString, systemImage: Constants.downloadsIconString) {
                Text(Constants.downloadsString)
            }
        }
    }
}

#Preview {
    ContentView()
}
