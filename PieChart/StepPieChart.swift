//
//  StepPieChart.swift
//  PieChart
//
//  Created by Amin on 12/15/1399 AP.
//

import SwiftUI

struct StepPieChart: View {
    @ObservedObject var charDataObj = ChartDataContainer()
    @State var indexOfTappedSlice = -1
    @State var lineSpace:CGFloat = 0.04
    @State var scale:CGFloat = 1
    var body: some View {
        VStack {
            ZStack(alignment:.leading){
                ForEach(0..<charDataObj.chartData.count) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                              to:  charDataObj.chartData[index].value/100)
                        //                        .foregroundColor(.blue)
                        //                        .stroke(charDataObj.chartData[index].color,lineWidth: 20)
                        .stroke(style: StrokeStyle(lineWidth: 100*((1 - (CGFloat(index)/CGFloat(charDataObj.chartData.count)))), lineCap: .butt, lineJoin: .bevel))
                        .foregroundColor(charDataObj.chartData[index].color)
                        
                        //                        .stroke(charDataObj.chartData[index].color,lineWidth: 100)
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring())
                        .rotationEffect(Angle(degrees: 270.0))
                    
                    
                }
            }.frame(width: 200, height: 250)
            .onAppear() {
                self.charDataObj.calc()
            }
            ForEach(0..<charDataObj.chartData.count) { index in
                HStack {
                    Text(String(format: "%.2f", Double(charDataObj.chartData[index].percent))+"%")
                        .onTapGesture {
                            indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                        }
                        .font(indexOfTappedSlice == index ? .headline : .subheadline)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(charDataObj.chartData[index].color)
                        .frame(width: 15, height: 15)
                }
            }
            .padding(8)
            .frame(width: 300, alignment: .trailing)
        }
        
    }
}

struct StepPieChart_Previews: PreviewProvider {
    static var previews: some View {
        StepPieChart()
    }
}
