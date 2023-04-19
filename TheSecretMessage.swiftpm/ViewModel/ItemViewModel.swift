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
    @Published var showBombView: Bool = false
    
    @Published var canvasImage: UIImage?
    @Published var boxHasBomb: Bool = false
    @Published var playerBRole: RoleType?
    @Published var isLockedByA: Bool = false
    @Published var isLockedByB: Bool = false
    @Published var playerAUnlock: Bool = false
    @Published var playerBUnlock: Bool = false
    
    @Published var playerAPassword: String = ""
    @Published var playerBPassword: String = ""
    @Published var playerAUnlockPassword: String = ""
    @Published var playerBUnlockPassword: String = ""
    @Published var showAWrongPasswordAlert: Bool = false
    @Published var showACorrectPasswordAlert: Bool = false
    @Published var showBWrongPasswordAlert: Bool = false
    @Published var showBCorrectPasswordAlert: Bool = false
    
    @Published var emitType: EmitType?
    @Published var bothWin: Bool = false
    @Published var playerAWin: Bool = false
    @Published var middleManWin: Bool = false
    @Published var bothLose: Bool = false
    
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
            showBombView.toggle()
        }
        
        resetPosition()
    }
    
    func resetPosition() {
        currentBoxPosition = ItemViewModel.initPosition
    }
    
    func isHighlighted(id: Int) -> Bool {
        highlightedID == id
    }
    
    func putBomb() {
        boxHasBomb = true
    }
    
    func checkPlayerAPassword() {
        withAnimation(.easeInOut) {
            if playerAPassword == playerAUnlockPassword {
                showACorrectPasswordAlert.toggle()
                playerAUnlock = true
            } else {
                showAWrongPasswordAlert.toggle()
            }
        }
    }
    
    func checkPlayerBPassword() {
        withAnimation(.easeInOut) {
            if playerBPassword == playerBUnlockPassword {
                showBCorrectPasswordAlert.toggle()
                playerBUnlock = true
            } else {
                showBWrongPasswordAlert.toggle()
            }
        }
    }
    
    func determineResult() {
        guard let playerBRole = playerBRole else { return }
        
        if playerBRole == .friend && !boxHasBomb {
            bothWin = true
            emitType = .bothWin
        }
        
        if playerBRole == .middleMan && boxHasBomb {
            playerAWin = true
            emitType = .playerAWin
        }
        
        if playerBRole == .middleMan && !boxHasBomb {
            middleManWin = true
            emitType = .middleManWin
        }
        if playerBRole == .friend && boxHasBomb {
            bothLose = true
            emitType = .bothLose
        }
    }
    
    func restartGame() {
        withAnimation(.easeInOut) {
            canvasImage = nil
            boxHasBomb = false
            playerBRole = nil
            isLockedByA = false
            isLockedByB = false
            playerAUnlock = false
            playerBUnlock = false
            playerAPassword = ""
            playerBPassword = ""
            playerAUnlockPassword = ""
            playerBUnlockPassword = ""
            showAWrongPasswordAlert = false
            showACorrectPasswordAlert = false
            showBWrongPasswordAlert = false
            showBCorrectPasswordAlert = false
            bothWin = false
            playerAWin = false
            middleManWin = false
            bothLose = false
        }
    }
}
