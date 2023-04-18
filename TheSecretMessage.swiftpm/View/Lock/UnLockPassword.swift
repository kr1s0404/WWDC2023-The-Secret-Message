//
//  SwiftUIView.swift
//  
//
//  Created by Kris on 4/18/23.
//

import SwiftUI

struct UnLockPassword: View
{
    let playerType: PlayerType
    
    @EnvironmentObject var itemVM: ItemViewModel
    
    @Binding var password: String
    
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View
    {
        VStack
        {
            Spacer()
            Text("Enter Your Password To Unlock The Box")
                .font(.system(size: 56))
                .fontWeight(.heavy)
                .shadow(radius: 5)
                .padding(.bottom, 100)
            
            HStack(spacing: 0)
            {
                ForEach(0 ..< 4, id: \.self) { index in
                    PasswordTextBox(index)
                }
            }
            .background(content: {
                TextField("", text: $password.limit(4))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            })
            .contentShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
            
            Button {
                itemVM.showLockView.toggle()
            } label: {
                Text("Unlcok")
                    .font(.system(size: 32))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.vertical, 30)
                    .frame(maxWidth: .infinity)
                    .background {
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .fill(.blue)
                    }
            }
            .disableWithOpacity(password.count < 4)
            
            Spacer()
        }
        .onDisappear {
            switch playerType {
            case .PlayerA:
                itemVM.checkPlayerAPassword()
            case .PlayerB:
                itemVM.checkPlayerBPassword()
            }
        }
        .padding(.all)
        .frame(maxHeight: .infinity,alignment: .top)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Done") {
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
            }
        }
    }
}

struct UnLockPassword_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        UnLockPassword(playerType: .PlayerA,
                       password: .constant(vm.playerAUnlockPassword))
            .environmentObject(vm)
    }
}

extension UnLockPassword {
    @ViewBuilder
    func PasswordTextBox(_ index: Int) -> some View {
        ZStack
        {
            if password.count > index {
                let startIndex = password.startIndex
                let charIndex = password.index(startIndex, offsetBy: index)
                let charToString = String(password[charIndex])
                
                Text(charToString)
                    .font(.title)
                    .fontWeight(.heavy)
            } else {
                Text(" ")
            }
        }
        .frame(width: 120, height: 120)
        .background {
            let status = (isKeyboardShowing && password.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? Color.primary : Color.gray, lineWidth: status ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: isKeyboardShowing)
        }
        .frame(maxWidth: .infinity)
    }
}
