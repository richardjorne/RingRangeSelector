import SwiftUI

@available(iOS 14.0, *)
public struct RingRangeSelector: View {

    var ringRadius: Double = 150
    var strokeWidth: Double = 50
    var buttonDiameter: Double = 50
    var shadowRadius: Double = 1.0
    var unit: Double? = nil
    var lineCap: CGLineCap = .butt
    var ringColor: Color = .blue
    var startColor: Color = .red
    var endColor: Color = Color( #colorLiteral(red: 194/256, green: 231/256, blue: 248/256, alpha: 1) )
    var backgroundColor: Color = .gray
    var startOverlayImage: String = ""
    var endOverlayImage: String = ""

    private var unitConverted: [Double] {
        var temp: Double = 0
        var tempArray: [Double] = [Double]()
        while temp < 0.9999 {
            tempArray.append(temp)
            temp += unit ?? 0.1
        }
        return tempArray
    }


    @Binding var startProgress: Double
    @Binding var endProgress: Double

    @State private var startLocation: CGPoint = CGPoint(x: 150, y: 0)//这里的start指的是开头的小圆圈
    @State private var translatedStartPos: CGPoint = CGPoint(x: 150, y: 0)
    @State private var endLocation: CGPoint = CGPoint(x: 150, y: 0)//这里的start指的是开头的小圆圈
    @State private var translatedEndPos: CGPoint = CGPoint(x: 150, y: 0)
    @State private var difference: Double = 0.5


    public var body: some View {
        ZStack(alignment: .center) {

            Circle()
                .stroke(style: StrokeStyle.init(lineWidth: strokeWidth,lineCap: lineCap))
                .foregroundColor(backgroundColor)

            Circle()
                .trim(from: 0, to: difference)
                .stroke(style: StrokeStyle.init(lineWidth: strokeWidth,lineCap: lineCap))
                .rotationEffect(.degrees(-90.0 + ( (startProgress*360.0))))
                .foregroundColor(ringColor)
                .onAppear {
                    calculateDifference(start: startProgress, end: endProgress)
                }
                .shadow(radius: shadowRadius)

            if unit != nil {
                ForEach(0..<unitConverted.count) { eachIndex in
                    Rectangle()
                        .frame(width: 1.2, height: buttonDiameter/3, alignment: .center)
                        .rotationEffect(.degrees(unitConverted[eachIndex]*360))
                        .position(CGPoint(x: ringRadius + (sin(unitConverted[eachIndex]*2*Double.pi) * (ringRadius)), y: (ringRadius)+cos(unitConverted[eachIndex]*2*Double.pi)*(-(ringRadius))))
                        .opacity(0.4)
                }
            }

            Circle()
                .aspectRatio(1,contentMode: .fit)
                .frame(width: buttonDiameter)
                .position(CGPoint(x: ringRadius + (sin(startProgress*2*Double.pi) * (ringRadius)), y: (ringRadius)+cos(startProgress*2*Double.pi)*(-(ringRadius))))
                .foregroundColor(startColor)
                .onAppear {
                    startLocation = CGPoint(x: ringRadius+sin(startProgress*2*Double.pi)*ringRadius, y: ringRadius+cos(startProgress*2*Double.pi)*(-ringRadius))
                }
                .gesture(DragGesture().onChanged({ value in
                    self.startLocation = value.location
                }))
                .onChange(of: startLocation) { newValue in
                    let x = newValue.x - ringRadius
                    var y = newValue.y - ringRadius
                    if x == 0 {return}
                    y = -y

                    let len = sqrt(pow(x,2) + pow(y,2))
                    let ratio: CGFloat = ringRadius / len
                    translatedStartPos.x = x*ratio
                    translatedStartPos.y = y*ratio
                    if x > 0 {
                        if y > 0 {
                            let s = asin((translatedStartPos.x)/ringRadius)/(2.0*Double.pi)
                            startProgress = s>1 ? 1 : s
                        }else {
                            let s = 0.25+(((Double.pi*0.5 -  asin((translatedStartPos.x)/ringRadius)) / 2.0) / Double.pi)
                            startProgress = s>1 ? 1 : s
                        }
                    }else {
                        if y > 0 {
                            let s = 1.0-(asin((-translatedStartPos.x)/ringRadius) / (2.0 * Double.pi))
                            startProgress = s>1 ? 1 : s
                        }else {
                            let s = (((Double.pi*1.0 + asin((-translatedStartPos.x)/ringRadius)) / 2.0) / Double.pi)
                            startProgress = s>1 ? 1 : s
                        }
                    }
                }


            Image(systemName: startOverlayImage)
                .foregroundColor(.white)
                .position(CGPoint(x: ringRadius + (sin(startProgress*2*Double.pi) * (ringRadius)), y: (ringRadius)+cos(startProgress*2*Double.pi)*(-(ringRadius))))
            Circle()
                .aspectRatio(1,contentMode: .fit)
                .frame(width: buttonDiameter)
                .position(x: ringRadius+sin(endProgress*2*Double.pi)*ringRadius, y: ringRadius+cos(endProgress*2*Double.pi)*(-ringRadius))
                .foregroundColor(endColor)
                .onAppear {
                    endLocation = CGPoint(x: ringRadius+sin(endProgress*2*Double.pi)*ringRadius, y: ringRadius+cos(endProgress*2*Double.pi)*(-ringRadius))
                }
                .gesture(DragGesture().onChanged({ value in
                    self.endLocation = value.location
                }))
                .onChange(of: endLocation) { newValue in
                    let x = newValue.x - ringRadius
                    var y = newValue.y - ringRadius
                    if x == 0 {return}
                    y = -y

                    let len = sqrt(pow(x,2) + pow(y,2))
                    let ratio: CGFloat = ringRadius / len
                    translatedEndPos.x = x*ratio
                    translatedEndPos.y = y*ratio
                    if x > 0 {
                        if y > 0 {
                            let s = asin((translatedEndPos.x)/ringRadius)/(2.0*Double.pi)//solution
                            endProgress = s>1 ? 1 : s
                        }else {
                            let s = 0.25+(((Double.pi*0.5 -  asin((translatedEndPos.x)/ringRadius)) / 2.0) / Double.pi)
                            endProgress = s>1 ? 1 : s
                        }
                    }else {
                        if y > 0 {
                            let s = 1.0-(asin((-translatedEndPos.x)/ringRadius) / (2.0 * Double.pi))
                            endProgress = s>1 ? 1 : s
                        }else {
                            let s = (((Double.pi*1.0 + asin((-translatedEndPos.x)/ringRadius)) / 2.0) / Double.pi)
                            endProgress = s>1 ? 1 : s
                        }
                    }
                }
            Image(systemName: endOverlayImage)
                .foregroundColor(.white)
                .position(x: ringRadius+sin(endProgress*2*Double.pi)*ringRadius, y: ringRadius+cos(endProgress*2*Double.pi)*(-ringRadius))
                .frame(width: ringRadius*2,height: ringRadius*2,alignment: .center)
                .onChange(of: startProgress) { newValue in

                    calculateDifference(start: newValue, end: endProgress)
                }
                .onChange(of: endProgress) { newValue in

                    calculateDifference(start: startProgress, end: newValue)
                }
        }
    }

    private func calculateDifference(start: Double, end: Double) {
        if end >= start || (1 + end - start)>1{
            difference = end - start
        }else {
            difference = 1 + end - start
        }
    }
}

