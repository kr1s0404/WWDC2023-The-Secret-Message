//
//  FriendUnlockView.swift
//  
//
//  Created by Kris on 4/19/23.
//

import SwiftUI

struct FriendUnlockView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        VStack
        {
            Spacer()
            MissionView
            
            Spacer()
            
            BoxView()
                .environmentObject(itemVM)
                .scaleEffect(1.5)
            
            Spacer()
            
            if itemVM.playerBUnlock {
                ReadMessageButton
            } else {
                LockButton
            }
            
            Spacer()
        }
        .navigationTitle("Third Pass")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightYellow)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $itemVM.showLockView) {
            UnLockPassword(playerType: .PlayerB,
                           password: $itemVM.playerBUnlockPassword)
        }
        .overlay {
            if itemVM.showWrongPasswordAlert { WrongPasswordView }
            
            if itemVM.showCorrectPasswordAlert { CorrectPasswordView }
        }
    }
}

struct FriendUnlockView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        FriendUnlockView()
            .environmentObject(vm)
    }
}


extension FriendUnlockView {
    private var MissionView: some View {
        VStack
        {
            Text("Mission")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .shadow(color: .green, radius: 10)
            
            Text("It has finally come to the end. \n\nPlayer A has unlock he/she's lock. There is only one lock left on the box. \n\nUnlock it, and you are able to read the message! ")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(width: 600, height: 300, alignment: .top)
        .background(Material.ultraThickMaterial)
        .cornerRadius(15)
    }
    
    private var LockButton: some View {
        Button {
            itemVM.showLockView.toggle()
        } label: {
            Text("Unlock the box")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding()
                .frame(width: 450, height: 120)
                .background(.blue)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .cornerRadius(15)
        }
    }
    
    private var ReadMessageButton: some View {
        NavigationLink {
            FinalView()
                .environmentObject(itemVM)
        } label: {
            Text("Check out the secret message")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .padding()
                .frame(width: 450, height: 120)
                .background(.blue)
                .foregroundColor(.white)
                .shadow(radius: 5)
                .cornerRadius(15)
        }
    }
    
    private var WrongPasswordView: some View {
        VStack
        {
            Text("Wrong Password!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 10)
        }
        .padding()
        .frame(width: 300, height: 150, alignment: .center)
        .background(.red.opacity(0.6))
        .cornerRadius(15)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                itemVM.showWrongPasswordAlert = false
                itemVM.showCorrectPasswordAlert = false
            }
        }
    }
    
    private var CorrectPasswordView: some View {
        VStack
        {
            Text("Successfully Unlock the Box!")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .foregroundColor(.white)
                .shadow(color: .black, radius: 10)
        }
        .padding()
        .frame(width: 300, height: 150, alignment: .center)
        .background(.green.opacity(0.6))
        .cornerRadius(15)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                itemVM.showWrongPasswordAlert = false
                itemVM.showCorrectPasswordAlert = false
            }
        }
    }
}
