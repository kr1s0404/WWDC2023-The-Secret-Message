//
//  File.swift
//  
//
//  Created by Kris on 4/7/23.
//

import SwiftUI

final class ItemViewModel: ObservableObject
{
    
    @Published var currentBoxPosition = initPosition
    @Published var highlightedID: Int?
    
    @Published var showCanvasView: Bool = false
    @Published var showLockView: Bool = false
    @Published var showBoomView: Bool = false
    
    @Published var canvasImage: UIImage?
    @Published var isLockedByA: Bool = false
    @Published var isLockedByB: Bool = false
    @Published var playerAUnlock: Bool = false
    @Published var playerBUnlock: Bool = false
    
    @Published var playerAPassword: String = ""
    @Published var playerBPassword: String = ""
    @Published var playerAUnlockPassword: String = ""
    @Published var playerBUnlockPassword: String = ""
    @Published var showWrongPasswordAlert: Bool = false
    @Published var showCorrectPasswordAlert: Bool = false
    
    let currentItem = Item.box
    
    private static let initPosition = CGPoint(x: 520, y: 170)
    
    private var frames: [Int: CGRect] = [:]
    
    var itemContainers = Item.all
    
    func update(frame: CGRect, for id: Int) {
        frames[id] = frame
    }
    
    func update(dragPosition: CGPoint) {
        currentBoxPosition = dragPosition
        
        for (id, frame) in frames where frame.contains(dragPosition) {
            highlightedID = id
            return
        }
        
        highlightedID = nil
    }
    
    func confirmDrop() {
        
        defer { highlightedID = nil }
        
        guard let highlightedID = highlightedID else { resetPosition(); return }
        
        if highlightedID == 1 {
            showCanvasView.toggle()
        } else if highlightedID == 2 {
            showLockView.toggle()
        } else if highlightedID == 3 {
            showBoomView.toggle()
        }
        
        resetPosition()
    }
    
    func resetPosition() {
        currentBoxPosition = ItemViewModel.initPosition
    }
    
    func isHighlighted(id: Int) -> Bool {
        highlightedID == id
    }
    
    func checkPlayerAPassword() {
        if playerAPassword == playerAUnlockPassword {
            showCorrectPasswordAlert.toggle()
            playerAUnlock = true
        } else {
            showWrongPasswordAlert.toggle()
        }
    }
    
    func checkPlayerBPassword() {
        if playerBPassword == playerBUnlockPassword {
            showCorrectPasswordAlert.toggle()
            playerBUnlock = true
        } else {
            showWrongPasswordAlert.toggle()
        }
    }
}
