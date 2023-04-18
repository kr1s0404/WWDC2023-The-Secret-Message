//
//  HomeView.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct HomeView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        VStack
        {
            Spacer()
            PlayerAMissionView
            Spacer()
            PlayerAView
            
            Spacer()
            
            NavigationLink {
                ItemView()
                    .environmentObject(itemVM)
            } label: {
                BoxView()
                    .environmentObject(itemVM)
            }
            
            Spacer()
            
            sendButton()
        }
        .navigationTitle("First Pass")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightYellow)
    }
}

extension HomeView {
    
    private var PlayerAMissionView: some View {
        VStack
        {
            Text("Mission")
                .font(.title)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .shadow(color: .blue, radius: 10)
            
            Text("Your goal is passing the secret message without letting the middle man know the message detail. After you wrote down your messsage, you can lock the box with 4 digtal numbers. \n\nPlayer B can chose to be a middle man or your friend (You won't know what he/she chose). If you think he/she chose middle man and will steal the secret message, you can set the Boom 💣 in the box. \n\nIf the middle man open the box, the Boom will explose 💥 and you win. But if Player B chose to be your friend and open the box that has a 💣, you both lose. If Player B chose to be your friend and you did not put the 💣 inside the box, you both win!")
                .font(.headline)
        }
        .padding()
        .frame(width: 500, height: 430, alignment: .top)
        .background(Material.ultraThickMaterial)
        .cornerRadius(15)
    }
    
    private var PlayerAView: some View {
        VStack
        {
            Text("Player A")
                .fontWeight(.heavy)
                .font(.largeTitle)
            Image(systemName: "figure.stand")
                .foregroundColor(.blue)
                .font(.system(size: 192))
                .shadow(color: .white, radius: 5)
        }
    }
    
    @ViewBuilder
    private func sendButton() -> some View {
        if itemVM.canvasImage == nil {
            SendButtonLebel(text: "Tap The Box To Add Stuffs",
                            image: "hand.tap",
                            status: false)
        } else {
            if itemVM.isLockedByA {
                NavigationLink {
                    ChoseRole()
                        .environmentObject(itemVM)
                } label: {
                    SendButtonLebel(text: "Send The Secret Message",
                                    image: "paperplane",
                                    status: true)
                }
            } else {
                SendButtonLebel(text: "You need to lock the box",
                                image: "lock.square",
                                status: false)
            }
        }
    }
    
    @ViewBuilder
    private func SendButtonLebel(text: String, image: String, status: Bool) -> some View {
        HStack
        {
            Text(text)
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .shadow(radius: 5)
            
            Image(systemName: image)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: 300, height: 80)
        .background(status ? Color.blue : Color.gray)
        .cornerRadius(15)
        .shadow(radius: 3)
        .padding(.bottom, 50)
    }
}

struct HomeView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        HomeView()
            .environmentObject(vm)
    }
}
