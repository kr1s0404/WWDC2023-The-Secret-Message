//
//  File.swift
//  
//
//  Created by Kris on 4/6/23.
//

import SwiftUI

final class IntroViewModel: ObservableObject
{
    @Published var currentPage: Int = 1
    
    @Published var totalPages: Int = 3
}
