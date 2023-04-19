//
//  PlayerAUnlockView.swift
//  
//
//  Created by Kris on 4/17/23.
//

import SwiftUI

struct PlayerAUnlockView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        VStack
        {
            Spacer()
            PlayerAMissionView
            
            Spacer()
            
            BoxView()
                .environmentObject(itemVM)
                .scaleEffect(1.5)
            
            Spacer()
            
            if itemVM.playerAUnlock {
                SendButton
            } else {
                LockButton
            }
            
            Spacer()
        }
        .navigationTitle("Second Pass: Player A's Phase")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightYellow)
        .navigationBarBackButtonHidden()
        .sheet(isPresented: $itemVM.showLockView) {
            UnLockPassword(playerType: .PlayerA,
                           password: $itemVM.playerAUnlockPassword)
        }
        .overlay {
            if itemVM.showAWrongPasswordAlert { WrongPasswordView }
            
            if itemVM.showACorrectPasswordAlert { CorrectPasswordView }
        }
    }
}

struct UnlockView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        PlayerAUnlockView()
            .environmentObject(vm)
    }
}

extension PlayerAUnlockView {
    private var PlayerAMissionView: some View {
        VStack
        {
            Text("Mission")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .shadow(color: .blue, radius: 10)
            
            Text("Now, you need to unlock the box with your password, and it will be send back to Player B. \n\nAfter Player B unlock the last lock on the box, he/she can read the secret message you sent. \n\nLet's hope he/she is on your side, otherwise, I hope you have put the bomb inside the box.")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(width: 600, height: 350, alignment: .top)
        .background(Material.ultraThickMaterial)
        .cornerRadius(15)
    }
    
    private var LockButton: some View {
        Button {
            itemVM.showLockView.toggle()
        } label: {
            HStack
            {
                Text("Unlock the box")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding()
                
                Image(systemName: "lock.open.fill")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
            }
            .padding()
            .frame(width: 450, height: 120)
            .background(.blue)
            .foregroundColor(.white)
            .shadow(radius: 5)
            .cornerRadius(15)
        }
    }
    
    private var SendButton: some View {
        NavigationLink {
            FriendUnlockView()
                .environmentObject(itemVM)
        } label: {
            HStack
            {
                Text("Send it back")
                    .fontWeight(.heavy)
                    .font(.largeTitle)
                    .padding()
                    
                Image(systemName: "arrow.up.square")
                    .font(.largeTitle)
            }
            .padding()
            .frame(width: 450, height: 120)
            .background(.green)
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
                itemVM.showAWrongPasswordAlert = false
                itemVM.showACorrectPasswordAlert = false
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
                itemVM.showAWrongPasswordAlert = false
                itemVM.showACorrectPasswordAlert = false
            }
        }
    }
}
