//
//  SwiftUIView.swift
//  Kudo
//
//  Created by Tran Huu Dang on 03/01/2023.
//

import SwiftUI

enum IndicatorType{
    case HorizontalBubble
    case CircleExpand
}

struct LoadingIndicator: View {
    var size : CGFloat = 10
    var color : Color = Color.blue
    var type : IndicatorType = .HorizontalBubble
    @State private var shouldAnimate = false
    var body: some View {
        switch type {
        case .HorizontalBubble:
            HStack(alignment: .center) {
                Circle()
                            .fill(color)
                            .frame(width: size, height: size)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever(), value: UUID())
                        Circle()
                            .fill(color)
                            .frame(width: size, height: size)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.3), value: UUID())
                        Circle()
                            .fill(color)
                            .frame(width: size, height: size)
                            .scaleEffect(shouldAnimate ? 1.0 : 0.5)
                            .animation(Animation.easeInOut(duration: 0.5).repeatForever().delay(0.6), value: UUID())
                    }
                    .onAppear {
                        self.shouldAnimate = true
                    }
        case .CircleExpand:
            HStack(alignment: .center){
                Circle()
                            .fill(color)
                            .frame(width: size, height: size)
                            .overlay(
                                ZStack {
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 50)
                                        .scaleEffect(shouldAnimate ? 0.1 : 0)
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 50)
                                        .scaleEffect(shouldAnimate ? 0.5 : 0)
                                    Circle()
                                        .stroke(Color.blue, lineWidth: 50)
                                        .scaleEffect(shouldAnimate ? 1 : 0)
                                }
                                .opacity(shouldAnimate ? 0.0 : 0.2)
                                .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: false), value: UUID())
                        )
                        .onAppear {
                            self.shouldAnimate = true
                        }
            }
        }
        
        
    }
    
}

struct LoadingIndicator_Previews: PreviewProvider {
    static var previews: some View {
        let horizontalBubble = LoadingIndicator()
        let circleExpand = LoadingIndicator(type: .CircleExpand)
        Group{
            horizontalBubble
            circleExpand
        }.previewLayout(.sizeThatFits)
    }
}
