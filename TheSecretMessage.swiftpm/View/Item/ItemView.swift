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
                        VStack
                        {
                            ItemContainer(itemVM: itemVM, item: item)
                            
                            switch item.type {
                            case .paper:
                                Text("A paper")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                Text("Write a secret message on it")
                                    .font(.headline)
                            case .lock:
                                Text("A lock")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                Text("Lock the box")
                                    .font(.headline)
                            case .bomb:
                                Text("A bomb")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                Text("Explode the middle man or your friend")
                                    .font(.headline)
                            default:
                                Color.clear
                            }
                        }
                    }
                }
                
                DraggableItem(item: itemVM.currentItem,
                              position: itemVM.currentBoxPosition,
                              gesture: drag)
            }
            
            Text("Drag The Box Over The Item You Want To Add")
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
        .alert(isPresented: $itemVM.showBombView) {
            Alert(
                title: Text("Put a bomb into the box 💣"),
                message: Text("Are you sure you want to add a bomb?"),
                primaryButton: .default(
                    Text("I'll think about it"),
                    action: { }
                ),
                secondaryButton: .destructive(
                    Text("I'm so sure, put it in"),
                    action: itemVM.putBomb
                )
            )
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
