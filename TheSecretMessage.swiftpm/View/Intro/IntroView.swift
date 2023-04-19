//
//  IntroView.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

struct IntroView: View
{
    @StateObject private var itemVM = ItemViewModel()
    @StateObject var introVM = IntroViewModel()
    
    var body: some View
    {
        NavigationView
        {
            if introVM.currentPage > introVM.totalPages {
                HomeView()
                    .environmentObject(itemVM)
            } else {
                WalkthroughScreen()
                    .environmentObject(introVM)
            }
        }
        .statusBarHidden()
        .navigationViewStyle(.stack)
    }
}

struct IntroView_Previews: PreviewProvider
{
    static var previews: some View
    {
        IntroView()
    }
}

struct WalkthroughScreen: View {
    
    @EnvironmentObject var introVM: IntroViewModel
    
    var body: some View
    {
        ZStack
        {
            if introVM.currentPage == 1 {
                ScreenView(image: "WDandMH",
                           title: "Background Knowledge",
                           detail: "The three-pass protocol is a method of securely transmitting information over an insecure channel, such as the internet. It involves three rounds of communication between two parties, often referred to as Alice and Bob. It was first proposed by  Whitfield Diffie and Martin Hellman in 1976. The first three-pass protocol was developed by Adi Shamir circa 1980, and is described in more detail in a later section and is widely used in modern cryptographic systems.",
                           bgColor: Color.lightYellow)
                .transition(.scale)
                .environmentObject(introVM)
            }
            
            if introVM.currentPage == 2 {
                ScreenView(image: "protocol",
                           title: "How does it works?",
                           detail: "In the first round, Alice and Bob exchange public keys. In the second round, Alice generates a random number and encrypts it with Bob's public key, and sends the encrypted message to Bob. In the third round, Bob decrypts the message using his private key, generates another random number, and sends the two random numbers encrypted with Alice's public key back to her. Alice can then decrypt the message using her private key and combine the two random numbers to generate a shared secret key that can be used to encrypt and decrypt subsequent messages.",
                           bgColor: Color.lightBlue)
                .transition(.scale)
                .environmentObject(introVM)
            }
            
            if introVM.currentPage == 3 {
                ScreenView(image: "middle-man",
                           title: "Potential Danger",
                           detail: "The three-pass protocol as described above does not provide any authentication. Hence, without any additional authentication the protocol is susceptible to a man-in-the-middle attack if the opponent has the ability to create false messages, or to intercept and replace the genuine transmitted messages. To mitigate this vulnerability, the three-pass protocol can be combined with additional security measures, such as digital signatures or message authentication codes.",
                           bgColor: Color.lightPink)
                .transition(.scale)
                .environmentObject(introVM)
            }
        }
        .overlay(nextButton(), alignment: .bottom)
    }
    
    @ViewBuilder
    private func nextButton() -> some View {
        Button(action: {
            withAnimation(.easeInOut) {
                if introVM.currentPage <= introVM.totalPages {
                    introVM.currentPage += 1
                }
            }
        }, label: {
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .clipShape(Circle())
                .overlay(
                    ZStack
                    {
                        Circle()
                            .stroke(Color.black.opacity(0.04),lineWidth: 4)
                        Circle()
                            .trim(from: 0, to: CGFloat(introVM.currentPage) / CGFloat(introVM.totalPages))
                            .stroke(Color.white,lineWidth: 4)
                            .rotationEffect(.init(degrees: -90))
                    }
                        .padding(-15))
        })
        .padding(.bottom,20)
    }
}

struct ScreenView: View
{
    @EnvironmentObject var introVM: IntroViewModel
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    var body: some View
    {
        VStack(spacing: 20)
        {
            HStack
            {
                if introVM.currentPage == 1 {
                    Text("The Secret Message！")
                        .font(.system(size: 72))
                        .fontWeight(.heavy)
                        .kerning(1.4)
                } else {
                    Button(action: {
                        withAnimation(.easeInOut) {
                            introVM.currentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.4))
                            .cornerRadius(10)
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut) {
                        introVM.currentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.bold)
                        .kerning(1.2)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer(minLength: 0)
            
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            Text(detail)
                .font(.system(size: 24))
                .fontWeight(.bold)
                .kerning(1.3)
                .multilineTextAlignment(.leading)
            
            Spacer(minLength: 120)
        }
        .padding(20)
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}
