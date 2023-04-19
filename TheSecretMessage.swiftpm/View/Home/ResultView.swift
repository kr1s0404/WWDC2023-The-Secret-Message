//
//  SuccessView.swift
//  
//
//  Created by Kris on 4/19/23.
//

import SwiftUI

struct ResultView: View
{
    let size = UIScreen.main.bounds.size
    
    @State var startEmission = false
    @State var endEmission = false
    
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                if itemVM.bothWin {
                    BothWinTitle
                } else if itemVM.playerAWin {
                    PlayerAWinTitle
                } else if itemVM.middleManWin {
                    MiddlemanWinTitle
                } else {
                    BothLoseTitle
                }
                
                if let message = itemVM.canvasImage {
                    Image(uiImage: message)
                        .resizable()
                        .frame(width: 700, height: 900)
                        .scaledToFit()
                        .cornerRadius(15)
                } else {
                    Color.clear
                        .frame(width: 700, height: 900)
                }
                
                NewGameButton
                
                Spacer()
            }
            .frame(width: size.width, height: size.height)
            .background(Color.lightPink)
            
            
            if let result = itemVM.emitType {
                EmitterView(result: result)
                    .scaleEffect(startEmission ? 1 : 0, anchor: .top)
                    .opacity(startEmission && !endEmission ? 1 : 0)
                    .offset(y: startEmission ? 0 : getRect().height / 2)
                    .ignoresSafeArea()
            }
            
        }
        .onAppear { doAnimation() }
        .navigationBarBackButtonHidden()
    }
}

struct SuccessView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        ResultView()
            .environmentObject(vm)
    }
}

extension ResultView {
    func doAnimation() {
        withAnimation(.spring()) {
            startEmission = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation(.easeInOut(duration: 1.5)) {
                endEmission = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                endEmission = false
                startEmission = false
            }
        }
    }
    
    private var BothWinTitle: some View {
        Text("Congratulations, \nYou both 👨🏼‍🤝‍👨🏿 nailed the\nThree-pass Protocol 🏆")
            .font(.system(size: 68))
            .fontWeight(.heavy)
            .shadow(color: .white, radius: 5)
            .padding()
    }
    
    private var PlayerAWinTitle: some View {
        Text("Only Player A 💪 win the\nThree-pass Protocol 🏆.\nCongratulations!")
            .font(.system(size: 68))
            .fontWeight(.heavy)
            .shadow(color: .white, radius: 5)
            .padding()
    }
    
    private var MiddlemanWinTitle: some View {
        Text("Only Middle Man 😈 win the\nThree-pass Protocol 🏆.\nCongratulations!")
            .font(.system(size: 68))
            .fontWeight(.heavy)
            .shadow(color: .white, radius: 5)
            .padding()
    }
    
    private var BothLoseTitle: some View {
        Text("Unfortunately, \nYou both ☠️ lose the\nThree-pass Protocol 😭")
            .font(.system(size: 68))
            .fontWeight(.heavy)
            .shadow(color: .white, radius: 5)
            .padding()
    }
    
    private var NewGameButton: some View {
        Button {
            itemVM.restartGame()
        } label: {
            Text("Start a new game")
                .font(.system(size: 48))
                .fontWeight(.semibold)
                .padding()
                .frame(width: 500, height: 110)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(15)
                .shadow(radius: 3)
                .padding()
        }
    }
}
