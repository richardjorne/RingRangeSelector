import SwiftUI

@available(iOS 15.0, *)
struct RingRangeSelectorExample_TimePicker: View {

    @State var startProgress: Double = 0
    @State var endProgress: Double = 0.25
    @State var startTime: (Int,Int) = (0,0)
    @State var endTime: (Int,Int) = (1,1)
    @State var difference: (Int,Int) = (1,1)

    var body: some View {
        ZStack(alignment: .center) {
            RingRangeSelector(
                ringRadius: 150,
                buttonDiameter: 35,
                unit: 1.0/24.0,
                lineCap: .round,
                ringColor: .cyan.opacity(0.8),
                startColor: Color( #colorLiteral(red: 150/256, green: 130/256, blue: 190/256, alpha: 1) ),
                //                endColor: Color( #colorLiteral(red: 165/256, green: 219/256, blue: 244/256, alpha: 1) ),
                endColor: Color( #colorLiteral(red: 231/256, green: 183/256, blue: 92/256, alpha: 1) ),
                backgroundColor: .gray.opacity(0.4),
                startOverlayImage: "moon.zzz",
                endOverlayImage: "sun.max",
                startProgress: $startProgress,
                endProgress: $endProgress
            )
            .frame(width: 300, height: 300, alignment: .center)
            VStack(alignment: .center) {
                Text("Sleep Start At")
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text("\(startTime.0.twoDigitString()):\(startTime.1.twoDigitString())")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .padding(.bottom)
                Text("Sleep End at")
                    .font(.system(size: 20, weight: .bold, design: .default))
                Text("\(endTime.0.twoDigitString()):\(endTime.1.twoDigitString())")
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .padding(.bottom)
                Text("In Total\n \(difference.0.twoDigitString())h \(difference.1.twoDigitString())min")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .multilineTextAlignment(.center)
            }
        }
        .onChange(of: startProgress) { newValue in
            startTime = (getHour(startProgress),getMin(startProgress))
            getDifference(start: startTime, end: endTime)
        }
        .onChange(of: endProgress) { newValue in
            endTime = (getHour(endProgress),getMin(endProgress))
            getDifference(start: startTime, end: endTime)
        }
        .onAppear {
            getDifference(start: startTime, end: endTime)
        }
    }

    func getHour(_ progress: Double) -> Int {
        return Int(24*progress)
    }
    func getMin(_ progress: Double) -> Int {
        return Int(1440*progress)%60
    }
    func getDifference(start: (Int,Int), end: (Int,Int)) {
        if (endProgress >= startProgress){
            if (end.1 >= start.1){
                difference = (end.0-start.0,end.1-start.1)
            }else{
                difference = (end.0-start.0-1,end.1-start.1+60)
            }
        }else {
            if (end.1 >= start.1){
                difference = (24+end.0-start.0,end.1-start.1)
            }else{
                difference = (24+end.0-start.0-1,end.1-start.1+60)
            }
        }
    }
}
extension Int {
    func twoDigitString() -> String {
        if self < 10 {
            return "0\(self)"
        }else {
            return "\(self)"
        }
    }
}


@available(iOS 15.0, *)
struct RingRangeSelector_Previews: PreviewProvider {
    static var previews: some View {
        RingRangeSelectorExample_TimePicker()
    }
}
