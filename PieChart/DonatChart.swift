//
//  donatPieChart.swift
//  PieChart
//
//  Created by Amin on 12/14/1399 AP.
//

import SwiftUI
struct DonutData: Equatable ,Identifiable{
        var id = UUID()
        var color : Color
        var percent : CGFloat
    
    static func == (lhs: DonutData, rhs: DonutData) -> Bool {
        return lhs.id == rhs.id &&
            lhs.color == rhs.color &&
            lhs.percent == rhs.percent
    }
}
class DonutChartModel : ObservableObject {
    @Published var chartData =
        [
            DonutData(color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 35),
            DonutData(color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 32),
            DonutData(color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 20),
            DonutData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 11),
            DonutData(color: Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)), percent: 2)
            
        ]
}


struct DonutChart: View {
    @ObservedObject var viewModel = DonutChartModel()
    @State var selectedIndex = -1
    @State var show:Bool = false
    let lineWidth:CGFloat
    // this coefficient tells how much of pie is white space
    var coefficient:CGFloat
    init(lineWidth:CGFloat = 10 ,whiteSpace:Angle = Angle(degrees: 6)) {
        self.lineWidth = lineWidth
        self.coefficient = CGFloat(whiteSpace.degrees/100)
        self.coefficient = self.coefficient*CGFloat(viewModel.chartData.count)
    }
    func from(for index:Int) -> CGFloat {
        var float :CGFloat = 0
        if index != 0 {
            for i in 0...index-1 {
                float += reducedPercent(for: i) + gapCoefficent
            }
        }
        
        return float
    }
    func to(for index:Int) ->CGFloat {
        from(for: index) + reducedPercent(for: index)
    }
    
    func reducedPercent(for index:Int) -> CGFloat {
        CGFloat((percent(for: index) - (percent(for: index) * coefficient)))
    }
    func percent(for index:Int) ->CGFloat {
        return CGFloat(viewModel.chartData[index].percent/100)
    }

    var gapCoefficent:CGFloat{
        coefficient/CGFloat(viewModel.chartData.count)
    }
   
    var body: some View {
        VStack {
            ZStack{
                
                ForEach(0..<viewModel.chartData.count) { index in
                    Circle()
                        .trim(from: show ? from(for: index) : 0, to: show ? to(for: index) : 0)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round, miterLimit: .zero))
                        .scaleEffect(index == selectedIndex ? 1.1 : 1.0)
                        .foregroundColor(viewModel.chartData[index].color)
                        .animation(.spring())
                        .onTapGesture {

                                selectedIndex = selectedIndex == index ? -1 : index

                        }
                        .scaleEffect(show ? 1 : 0)
                        .rotationEffect(Angle(degrees: -90))

                        
                }
                Text(selectedIndex == -1 ? "reload" : String(format: "%.0f", viewModel.chartData[selectedIndex].percent)+"%")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .onTapGesture {
                        show = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            show = true
                        }
                    }
                .onAppear{
                   show = true
                }
                // for animating when data changes
                
                    .onChange(of: viewModel.chartData) { (_) in
                    show = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        show = true
                    }
                }
                
            }.frame(width: 150, height: 150)

            
            ForEach(0..<viewModel.chartData.count) { index in
                HStack {
                    Text(String(format: "%.2f", Double(viewModel.chartData[index].percent))+"%")
                        .onTapGesture {
//                            withAnimation(.easeIn(duration:0.5)) {
                                selectedIndex = selectedIndex == index ? -1 : index
//                            }
                        }
                        .font(selectedIndex == index ? .headline : .subheadline)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(viewModel.chartData[index].color)
                        .frame(width: 15, height: 15)
                }
            }
            .padding(8)
            .frame(width: 300, alignment: .trailing)
//            Button ("s"){
//                viewModel.chartData = [
//                    DonutData(color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 50),
//                    DonutData(color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 30),
//                    DonutData(color: Color(#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)), percent: 10),
//                    DonutData(color: Color(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)), percent: 10),
//                ]
//            }
        }
        
    }
}

struct donatPieChart_Previews: PreviewProvider {
    static var previews: some View {
        DonutChart()
    }
}

