//
//  FriendView.swift
//  
//
//  Created by Kris on 4/14/23.
//

import SwiftUI

struct FriendView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    @State private var loadingText: [String] = "Delivering the secret message ... 📦"
        .map({ String($0) })
    @State private var counter: Int = 0
    @State private var loops: Int = 0
    @State private var boxOffset = CGSize(width: -500, height: 0)
    @State private var isBoxMoving: Bool = true
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack
        {
            if isBoxMoving {
                LoadingText
            } else {
                if itemVM.isLockedByB {
                    Text("Send the box back to Player A")
                        .font(.system(size: 48))
                        .fontWeight(.heavy)
                        .animation(.spring(), value: itemVM.isLockedByB)
                        .shadow(color: .red, radius: 3)
                        .padding()
                } else {
                    Text("Your secret message is here !")
                        .font(.system(size: 48))
                        .fontWeight(.heavy)
                        .animation(.spring(), value: isBoxMoving)
                        .shadow(color: .yellow, radius: 3)
                        .padding()
                }
            }
            
            FriendViewDescription()
            
            Spacer()
            
            BoxView()
                .offset(x: boxOffset.width)
                .animation(.spring(response: 5.5), value: boxOffset)
                .onAppear { boxOffset = .zero }
                .scaleEffect(1.5)
            
            Spacer()
            
            if itemVM.isLockedByB {
                sendBackButton
            } else {
                LockButton
            }
            
            Spacer()
        }
        .navigationTitle("Second Pass")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightPink)
        .onReceive(timer) { _ in
            hideDeliveryTitle()
        }
        .onDisappear { timer.upstream.connect().cancel() }
        .sheet(isPresented: $itemVM.showLockView) {
            PasswordView(playerType: .PlayerB,
                         password: $itemVM.playerBPassword)
        }
    }
}

struct FriendView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        FriendView()
            .environmentObject(vm)
    }
}

extension FriendView {
    private func hideDeliveryTitle() {
        withAnimation(.spring()) {
            let lastIndex = loadingText.count - 1
            
            if counter == lastIndex {
                counter = 0
                loops += 1
                
                if loops >= 1 {
                    isBoxMoving = false
                }
                
            } else {
                counter += 1
            }
        }
    }
    
    private var LoadingText: some View {
        HStack(spacing: 0)
        {
            ForEach(loadingText.indices, id: \.self) { i in
                Text(loadingText[i])
                    .font(.system(size: 48))
                    .fontWeight(.heavy)
                    .offset(y: counter == i ? -14 : 0)
            }
        }
        .padding()
    }
    
    private var LockButton: some View {
        Button {
            itemVM.showLockView.toggle()
        } label: {
            Text("Add my lock on the box")
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
    
    private var sendBackButton: some View {
        NavigationLink {
            PlayerAUnlockView()
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
            .background(.blue)
            .foregroundColor(.white)
            .shadow(radius: 5)
            .cornerRadius(15)
        }
    }
}


struct FriendViewDescription: View
{
    var body: some View
    {
        VStack
        {
            Text("Mission")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .shadow(color: .green, radius: 10)
            
            Text("The box is currently locked by Player A's password. \n\nAdd your own lock and password on it. Then it will be send back to Player A to unlock the box. \n\nOnce it was unlock from player A, the box will deliver to you again. \n\nFinally, you can read the secret message.")
                .font(.title2)
                .fontWeight(.semibold)
        }
        .padding()
        .frame(width: 550, height: 380, alignment: .top)
        .background(Material.ultraThickMaterial)
        .cornerRadius(15)
        .padding(20)
    }
}
