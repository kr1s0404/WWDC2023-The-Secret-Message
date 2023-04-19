//
//  CanvasView.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct CanvasView: View
{
    @Environment(\.displayScale) var displayScale
    
    @EnvironmentObject var itemVM: ItemViewModel
    
    @State private var currentLine = Line()
    @State private var lines: [Line] = []
    @State private var thickness: Double = 1.0
    
    var canvas: some View {
        Canvas { context, size in
            for line in lines {
                var path = Path()
                path.addLines(line.points)
                context.stroke(path, with: .color(line.color),
                               lineWidth: line.lineWidth)
            }
        }
        .frame(maxWidth: 700, maxHeight: 900)
        .frame(minWidth: 400, minHeight: 400)
        .gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
            .onChanged({ value in
                let newPoint = value.location
                currentLine.points.append(newPoint)
                self.lines.append(currentLine)
            })
                .onEnded({ value in
                    self.lines.append(currentLine)
                    self.currentLine = Line(points: [], color: currentLine.color, lineWidth: thickness)
                })
        )
    }
    
    var body: some View
    {
        VStack
        {
            canvas
            
            HStack
            {
                Slider(value: $thickness, in: 1...20) {
                    Text("Thickness")
                }
                .frame(maxWidth: 400)
                .onChange(of: thickness) { newThickness in
                    currentLine.lineWidth = newThickness
                }
                .padding(.horizontal)
                
                ColorPickerView(selectedColor: $currentLine.color)
                    .onChange(of: currentLine.color) { newColor in
                        currentLine.color = newColor
                    }
                    .padding(.horizontal)
            }
        }
        .padding(.bottom)
        .overlay(alignment: .topTrailing) {
            Button {
                let canvasImage = canvas
                    .frame(width: 700, height: 900)
                    .snapshot()
                itemVM.canvasImage = canvasImage
                itemVM.showCanvasView = false
            } label: {
                Text("Save the message")
                    .fontWeight(.heavy)
                    .font(.title)
                    .padding()
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(10)
                    .padding()
            }
        }
    }
}

struct CanvasView_Previews: PreviewProvider
{
    static var previews: some View
    {
        CanvasView()
    }
}
