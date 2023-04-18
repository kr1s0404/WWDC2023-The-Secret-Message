//
//  BoxView.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct BoxView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        VStack
        {
            Image(systemName: "shippingbox")
                .foregroundColor(.brown)
                .font(.system(size: 132))
                .shadow(radius: 10)
                .overlay(alignment: .topTrailing) {
                    if itemVM.playerAUnlock {
                        Image(systemName: "lock.open.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 52))
                            .shadow(radius: 5)
                    } else if itemVM.isLockedByA {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 52))
                            .shadow(radius: 5)
                    }
                }
                .overlay(alignment: .bottomLeading) {
                    if itemVM.canvasImage != nil {
                        Image(systemName: "newspaper.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 48))
                            .shadow(radius: 5)
                    }
                }
                .overlay(alignment: .bottomTrailing) {
                    if itemVM.playerBUnlock {
                        Image(systemName: "lock.open.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 52))
                            .shadow(radius: 5)
                    } else if itemVM.isLockedByB {
                        Image(systemName: "lock.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 52))
                            .shadow(radius: 5)
                    }
                }
            
            if itemVM.canvasImage != nil {
                if itemVM.isLockedByA {
                    Text("The box contains a secret message")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(.top, 3)
                } else {
                    Text("The box contains a message")
                        .fontWeight(.heavy)
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(.top, 3)
                }
            } else {
                Text("The box is empty ")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding(.top, 3)
            }
        }
    }
}

struct BoxView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        BoxView()
            .environmentObject(vm)
    }
}
