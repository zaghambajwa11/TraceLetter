//
//  ContentView.swift
//  TraceLetter
//
//  Created by Zagham Arshad on 03/04/2023.
//

import SwiftUI

struct LetterTraceView: View {
    
    @State private var tracePath = Path()
    @State private var lastPoint = CGPoint.zero
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            Path { path in
                path.addRect(CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
            }
            .fill(Color.white)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let currentPoint = value.location
                        if abs(currentPoint.x - lastPoint.x) > 10 || abs(currentPoint.y - lastPoint.y) > 10 {
                            tracePath.move(to: currentPoint)
                        } else {
                            tracePath.addLine(to: currentPoint)
                        }
                        lastPoint = currentPoint
                    }
                    .onEnded { value in
                        tracePath = Path()
                        lastPoint = .zero
                    }
            )
            Text("Trace the Letter A")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
            Path { path in
                path.addArc(center: CGPoint(x: UIScreen.main.bounds.width/2, y: UIScreen.main.bounds.height/2), radius: 100, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)
            }
            .stroke(Color.black, lineWidth: 5)
            .background(Color.white)
        }
    }
}

struct LetterTraceApp: App {
    var body: some Scene {
        WindowGroup {
            LetterTraceView()
        }
    }
}

