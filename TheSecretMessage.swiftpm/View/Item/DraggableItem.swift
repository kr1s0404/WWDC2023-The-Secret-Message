//
//  DraggableItem.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct DraggableItem<Draggable: Gesture>: View
{
    let item: Item
    private let size: CGFloat = 150
    let position: CGPoint
    let gesture: Draggable
    
    var body: some View
    {
        VStack
        {
            switch item.type {
            case .box:
                Image(systemName: "shippingbox")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.brown)
                    .frame(width: size, height: size)
                    .position(position)
                    .gesture(gesture)
            case .paper:
                Image(systemName: "newspaper")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: size, height: size)
                    .position(position)
                    .gesture(gesture)
            case .lock:
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
                    .frame(width: size, height: size)
                    .position(position)
                    .gesture(gesture)
            case .boom:
                Text("💣")
                    .font(.system(size: 116))
                    .frame(width: size, height: size)
                    .position(position)
                    .gesture(gesture)
            }
        }
        .shadow(radius: 10)
    }
}

struct DraggableItem_Previews: PreviewProvider
{
    static var previews: some View
    {
        DraggableItem(item: Item.all[0],
                      position: CGPoint(x: 100, y: 100),
                      gesture: DragGesture())
    }
}
