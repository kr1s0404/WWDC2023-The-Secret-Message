//
//  ItemView.swift
//  
//
//  Created by Kris on 4/7/23.
//

import SwiftUI

struct ItemView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    let gridItem = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var drag: some Gesture {
        DragGesture()
            .onChanged { state in
                itemVM.update(dragPosition: state.location)
            }
            .onEnded { state in
                itemVM.update(dragPosition: state.location)
                withAnimation(.spring()) {
                    itemVM.confirmDrop()
                }
            }
    }
    
    var body: some View
    {
        VStack
        {
            ZStack
            {
                LazyVGrid(columns: gridItem) {
                    ForEach(itemVM.itemContainers, id: \.id) { item in
                        ItemContainer(itemVM: itemVM, item: item)
                    }
                }
                
                DraggableItem(item: itemVM.currentItem,
                              position: itemVM.currentBoxPosition,
                              gesture: drag)
            }
            
            Text("Move The Box To The Item You Want To Add")
                .fontWeight(.heavy)
                .font(.largeTitle)
        }
        .background(Color.lightBlue)
        .sheet(isPresented: $itemVM.showCanvasView) {
            CanvasView()
                .environmentObject(itemVM)
        }
        .sheet(isPresented: $itemVM.showLockView) {
            PasswordView(playerType: .PlayerA,
                         password: $itemVM.playerAPassword)
                .environmentObject(itemVM)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        ItemView()
            .environmentObject(vm)
    }
}
