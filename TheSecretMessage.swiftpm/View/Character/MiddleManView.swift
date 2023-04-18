//
//  MiddleManView.swift
//  
//
//  Created by Kris on 4/14/23.
//

import SwiftUI

struct MiddleManView: View
{
    @EnvironmentObject var itemVM: ItemViewModel
    
    var body: some View
    {
        Text("Hello, World!")
    }
}

struct MiddleManView_Previews: PreviewProvider
{
    static let vm = ItemViewModel()
    
    static var previews: some View
    {
        MiddleManView()
            .environmentObject(vm)
    }
}
