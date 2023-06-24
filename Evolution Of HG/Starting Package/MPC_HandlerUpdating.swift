//
//  MPC_Handler.swift
//  Hunger Games
//
//  Created by kbice on 5/7/20.
//  Copyright © 2020 Keller Bice. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class MPC_Handler: NSObject, MCSessionDelegate {
    
    var peerID:MCPeerID?
    var session:MCSession!
    var browers:MCBrowserViewController!
    var advertiser:MCAdvertiserAssistant? = nil
    
    func setupPeerWithDisplayName(DisplayName: String) {
        peerID = MCPeerID(displayName: DisplayName )
    }
    
    func setupSession() {
        session = MCSession(peer:peerID!, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.none)
        session.delegate = self
    }
    
    func setupBrowser() {
         browers = MCBrowserViewController(serviceType: "MyGame", session: session)
    }
    
    func advertiseSelf(advertise: Bool) {
        if advertise {
            advertiser = MCAdvertiserAssistant(serviceType: "MyGame", discoveryInfo: nil, session: session)
            advertiser!.start()
        } else {
            advertiser!.stop()
            advertiser = nil
        }
    }
    
    
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        
        switch state {
        case MCSessionState.connected:
            UserDefaults.standard.set(true, forKey: "connected")
            print("connected")
        case MCSessionState.connecting:
            UserDefaults.standard.set(false, forKey: "connected")
            print("connecting")
        case MCSessionState.notConnected:
            UserDefaults.standard.set(false, forKey: "connected")
            print("not connected")
        @unknown default:
            fatalError()
        }
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                if !UserDefaults.standard.bool(forKey: "Ingame") {
                    let userInfo = ["data":data,"peerId":peerID] as [String : Any]
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidReciveDataNotification"), object: nil, userInfo: userInfo)
                } else {
                    do {
                        print(data)
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "NoLag"), object: data, userInfo: ["from":self])
                    } catch {
                        print("error")
                    }
                }
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        
    }
}
