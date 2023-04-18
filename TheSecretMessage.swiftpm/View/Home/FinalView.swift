//
//  SwiftUIView.swift
//  
//
//  Created by Kris on 4/19/23.
//

import SwiftUI

struct FinalView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        VStack
        {
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.lightPink)
    }
}

struct SwiftUIView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        FinalView()
            .environmentObject(vm)
    }
}

extension FinalView {
    
}
