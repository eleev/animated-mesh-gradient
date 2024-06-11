//
//  MeshGradientView.swift
//  AnimatedMeshGradient
//
//  Created by Astemir Eleev on 6/11/24.
//

import SwiftUI

struct MeshGradientView: View {
    @State var d: Float = 0.0
    @State var timer: Timer?
    
    var body: some View {
        ZStack {
            Color.black
            
            MeshGradient(
                width: 3,
                height: 3,
                points: [
                    [sine(in: (-0.5)...0.0, 0.2, 0.234, d, 1.0, 0.1, noiseFunction),
                     sine(in: (-0.4)...0.0, 0.2, 0.353, d, 1.0, 0.1, noiseFunction)],
                    [sine(in: 0.5...0.6, 0.2, 0.134, d, 1.0, 0.1, noiseFunction),
                     sine(in: -0.5...(-0.015), 0.15, 0.523, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: 1.1...1.5, 0.2, 0.214, d, 1.0, 0.1, noiseFunction),
                     sine(in: -0.1...0.0, 0.1, 0.053, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: -0.8...(-0.1), 1.439, 0.342, d, 1.0, 0.1, noiseFunction),
                     sine(in: 0.3...0.7, 4.42, 0.984, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: 0.1...0.8, 0.239, 0.084, d, 1.0, 0.1, noiseFunction),
                     sine(in: 0.2...0.8, 5.21, 0.242, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: 1.0...1.5, 0.939, 0.084, d, 1.0, 0.1, noiseFunction),
                     sine(in: 0.4...0.8, 0.25, 0.642, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: -0.8...0.0, 1.439, 0.442, d, 1.0, 0.1, noiseFunction),
                     sine(in: 1.4...1.9, 3.42, 0.984, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: 0.25...0.65, 0.339, 0.784, d, 1.0, 0.1, noiseFunction),
                     sine(in: 1.1...1.2, 0.124, 0.772, d, 1.0, 0.1, noiseFunction)],
                    
                    [sine(in: 1.0...1.5, 0.939, 0.056, d, 1.0, 0.1, noiseFunction),
                     sine(in: 1.3...1.7, 0.47, 0.342, d, 1.0, 0.1, noiseFunction)]
                ], colors: [
                    .black, .blue, .black,
                    .orange, .white, .red,
                    .yellow, .black, .pink
                ])
        }
        .ignoresSafeArea()
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                d += 0.05
            })
        }
    }
    
    private func noiseFunction(_ t: Float) -> Float {
        return (sin(t * 0.5) + cos(t * 0.25)) / 2
    }
    
    private func sine(
        in range: ClosedRange<Float>,
        _ offset: Float,
        _ scale: Float,
        _ t: Float,
        _ frequencyModulation: Float,
        _ noiseAmplitude: Float,
        _ noiseFunction: (Float) -> Float
    ) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2

        // Primary sine wave
        let primarySine = sin(scale * t + offset)
        
        // Frequency modulation using another sine wave
        let modulatingSine = sin(frequencyModulation * t + offset)
        
        // Noise factor to add randomness
        let noiseFactor = noiseFunction(t) * noiseAmplitude
        
        // Combining primary sine, frequency modulation, and noise
        return midPoint + amplitude * (primarySine + modulatingSine * noiseFactor)
    }
}

#Preview {
    MeshGradientView()
}
