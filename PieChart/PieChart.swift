//
//  PieChart.swift
//  PieChart
//
//  Created by Amin on 12/14/1399 AP.
//

import SwiftUI


//MARK:- Chart Data
struct ChartData {
    var id = UUID()
    var color : Color
    var percent : CGFloat
    var value : CGFloat
    
}


struct PieChart: View {
    @ObservedObject var charDataObj = ChartDataContainer()
    @State var indexOfTappedSlice = -1
        @State var lineSpace:CGFloat = 0
    var body: some View {
        VStack {
            ZStack{
                ForEach(0..<charDataObj.chartData.count) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : charDataObj.chartData[index-1].value/100,
                              to:  charDataObj.chartData[index].value/100 - lineSpace)
//                        .foregroundColor(.blue)
                        .stroke(charDataObj.chartData[index].color,lineWidth: 20)
//                        .stroke(style: StrokeStyle(lineWidth: 20.0, lineCap: .round, lineJoin: .bevel))
                        .foregroundColor(charDataObj.chartData[index].color)
                        //                        .stroke(charDataObj.chartData[index].color,lineWidth: 100)
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring())
                        .rotationEffect(Angle(degrees: 180))
                    //                        .offset(x:CGFloat(index*10))
                    //                        .rotationEffect(Angle(degrees: Double(index*10)))
                    //                       (((charDataObj.chartData[index-1].value)/100)-0.5*((charDataObj.chartData[index-1].value)/100))
                    
                    
                }
            }.frame(width: 200, height: 200)
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




struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart()
    }
}


class ChartDataContainer : ObservableObject {
    @Published var chartData =
        [
            ChartData(color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 35, value: 0),
            ChartData(color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 32, value: 0),
            ChartData(color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 20, value: 0),
            ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 11, value: 0),
            ChartData(color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), percent: 2, value: 0)
        ]
    
    //    init() {
    //        calc()
    //    }
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
}
