//
//  ItemContainer.swift
//  
//
//  Created by Kris on 4/7/23.
//

import SwiftUI

struct ItemContainer: View
{
    @ObservedObject var itemVM: ItemViewModel
    
    let item: Item
    private let size: CGFloat = 150
    private let highlightedSize: CGFloat = 200
    
    var body: some View
    {
        ZStack
        {
            switch item.type {
            case .box:
                Image(systemName: "shippingbox")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.brown)
                    .frame(width: size, height: size)
                    .overlay {
                        GeometryReader { proxy -> Color in
                            itemVM.update(frame: proxy.frame(in: .global),
                                          for: item.id)
                            
                            return Color.clear
                        }
                    }
            case .paper:
                Image(systemName: "newspaper")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
                    .frame(width: size, height: size)
                    .overlay {
                        GeometryReader { proxy -> Color in
                            itemVM.update(frame: proxy.frame(in: .global),
                                          for: item.id)
                            
                            return Color.clear
                        }
                    }
            case .lock:
                Image(systemName: "lock")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.yellow)
                    .frame(width: size, height: size)
                    .overlay {
                        GeometryReader { proxy -> Color in
                            itemVM.update(frame: proxy.frame(in: .global),
                                          for: item.id)
                            
                            return Color.clear
                        }
                    }
            case .boom:
                Text("💣")
                    .font(.system(size: 116))
                    .frame(width: size, height: size)
                    .overlay {
                        GeometryReader { proxy -> Color in
                            itemVM.update(frame: proxy.frame(in: .global),
                                          for: item.id)
                            
                            return Color.clear
                        }
                    }
            }
            
            if itemVM.isHighlighted(id: item.id) {
                Circle()
                    .fill(.red)
                    .opacity(0.4)
                    .frame(width: highlightedSize, height: highlightedSize)
                    .animation(.easeInOut, value: itemVM.isHighlighted(id: item.id))
            }
        }
        .frame(width: highlightedSize, height: highlightedSize)
    }
}

struct ItemContainer_Previews: PreviewProvider
{
    static var previews: some View
    {
        ItemContainer(itemVM: ItemViewModel(), item: Item.all.first!)
    }
}
