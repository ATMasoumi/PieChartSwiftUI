//
//  ContentView.swift
//  PieChart
//
//  Created by Amin on 12/14/1399 AP.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = DonutChartModel()
    @State var selectedIndex = -1
    var body: some View {
        DonutChart()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
