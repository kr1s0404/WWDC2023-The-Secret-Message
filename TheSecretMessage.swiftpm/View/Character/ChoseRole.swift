//
//  ChoseRole.swift
//  
//
//  Created by Kris on 4/7/23.
//

import SwiftUI

struct ChoseRole: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        VStack
        {
            Spacer()
            Text("Player B: Chose Which Role You Want To Play")
                .fontWeight(.heavy)
                .font(.largeTitle)
            
            Spacer()
            
            
            HStack
            {
                CharacterButton(roleType: .middleMan,
                                image: "figure.walk")
                    .environmentObject(itemVM)
                CharacterButton(roleType: .friend,
                                image: "figure.wave")
                    .environmentObject(itemVM)
            }
            
            Spacer()
            Text("You can betray 😈 Player A or cooperate 🤝🏻 with he/she")
                .bold()
                .font(.title)
            Spacer()
        }
        .background(Color.lightBlue)
    }
}

struct ChoseRole_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        ChoseRole()
            .environmentObject(vm)
    }
}

enum RoleType {
    case middleMan
    case friend
}

struct CharacterButton: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    let roleType: RoleType
    let image: String
    
    var body: some View
    {
        VStack
        {
            switch roleType {
            case .middleMan:
                NavigationLink {
                    PlayerBLockView()
                        .environmentObject(itemVM)
                } label: {
                    VStack
                    {
                        MiddleManMissionView()
                        MiddleManButton
                    }
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            itemVM.playerBRole = .middleMan
                        }
                )
            case .friend:
                NavigationLink {
                    PlayerBLockView()
                        .environmentObject(itemVM)
                } label: {
                    VStack
                    {
                        FriendMissionView()
                        FriendButton
                    }
                }
                .simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            itemVM.playerBRole = .friend
                        }
                )
            }
        }
        .navigationBarBackButtonHidden()
    }
}

extension CharacterButton {
    private var MiddleManButton: some View {
        VStack
        {
            Text("Middle Man")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .red, radius: 10)
            Image(systemName: image)
                .font(.system(size: 192))
                .foregroundColor(.red)
                .shadow(color: .white, radius: 5)
        }
        .shadow(color: .white, radius: 5)
    }
    
    private var FriendButton: some View {
        VStack
        {
            Text("Friend")
                .fontWeight(.heavy)
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .green, radius: 10)
            Image(systemName: image)
                .font(.system(size: 192))
                .foregroundColor(.green)
                .shadow(color: .white, radius: 5)
        }
        .shadow(color: .white, radius: 5)
    }
}


struct MiddleManMissionView: View
{
    var body: some View
    {
        VStack
        {
            Text("Mission")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .shadow(color: .red, radius: 10)
            
            Text("Your goal is steal the secret message without getting explode 💥 by the bomb. If you chose to be a middle man, you have to pretend that you are Player A's friend and lock the box with your 4 digital numbers. And the box will be send back back to Player A. \n\nAfter Player A unlock the box, you can steal the secret message and you win! But if Player A think you might be a middle man, he/she may put a Bomb 💣 inside the box, it will explode and you lose. \n\nTry your best to tirck Player A that you are friendly and not a middle man!")
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(width: 450, height: 430, alignment: .top)
        .frame(maxWidth: .infinity)
        .background(Material.ultraThickMaterial)
        .cornerRadius(15)
        .padding(20)
    }
}

struct FriendMissionView: View
{
    var body: some View
    {
        VStack
        {
            Text("Mission")
                .foregroundColor(.black)
                .font(.title)
                .fontWeight(.heavy)
                .padding(.vertical, 5)
                .shadow(color: .green, radius: 10)
            
            Text("Your goal is decrypt the secret message from Player A. If you chose to be Player A's friend, you have to make he/she trust you. After receiving the box from Player A, you have to lock it with your 4 digital numbers. \n\nNow the box will have two lock, and the box will send back to Player A to unlock the first lock. Now, there is only one lock left on the box, and you can unlock it and read the secret message. \n\nIf you get the message successfully, you win. Becareful! Player A may not trust you, he/she might put a Bomb 💣 inside the Box. If the box contains a bomb, you both lose.")
                .font(.headline)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
        .padding()
        .frame(width: 450, height: 430, alignment: .top)
        .frame(maxWidth: .infinity)
        .background(Material.ultraThickMaterial)
        .cornerRadius(15)
        .padding(20)
    }
}
