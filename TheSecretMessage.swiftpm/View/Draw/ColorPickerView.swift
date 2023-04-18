//
//  ColorPickerView.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct ColorPickerView: View {
    
    let colors = [Color.red, Color.orange, Color.green, Color.blue, Color.purple]
    @Binding var selectedColor: Color
    
    var body: some View
    {
        HStack
        {
            ForEach(colors, id: \.self) { color in
                Image(systemName: selectedColor == color ? Constants.Icons.recordCircleFill : Constants.Icons.circleFill)
                    .foregroundColor(color)
                    .font(.system(size: 32))
                    .clipShape(Circle())
                    .onTapGesture { selectedColor = color }
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ColorPickerView(selectedColor: .constant(.blue))
    }
}
