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
                ScreenView(image: "image1",
                           title: "Step 1",
                           detail: "",
                           bgColor: Color.lightYellow)
                .transition(.scale)
                .environmentObject(introVM)
            }
            
            if introVM.currentPage == 2 {
                ScreenView(image: "image2",
                           title: "Step 2",
                           detail: "",
                           bgColor: Color.lightBlue)
                .transition(.scale)
                .environmentObject(introVM)
            }
            
            if introVM.currentPage == 3 {
                ScreenView(image: "image3",
                           title: "Step 3",
                           detail: "",
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
                        .font(.largeTitle)
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
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding(.top)
            
            Text("Lorem ipsum is dummy text used in laying out print, graphic or web designs.")
                .fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .padding(20)
        .background(bgColor.cornerRadius(10).ignoresSafeArea())
    }
}
