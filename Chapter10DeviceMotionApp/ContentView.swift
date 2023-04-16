//
//  ContentView.swift
//  Chapter10DeviceMotionApp
//
//  Created by Timur on 16.04.2023.
//

import SwiftUI
import CoreMotion

struct ContentView: View {
    
    let motionManager = CMMotionManager()
    let queue = OperationQueue()
    
    @State private var pitch: Double = 0.0
    @State private var yaw: Double = 0.0
    @State private var roll: Double = 0.0

    var body: some View {
        VStack {
            Text("Pitch: \(pitch)")
            Text("Yaw: \(yaw)")
            Text("Roll: \(roll)")
        }.onAppear{
            motionManager.startDeviceMotionUpdates(to: queue) {(data: CMDeviceMotion?, error: Error?) in
                guard let data = data else{
                    print("Error: \(error!)")
                    return
                }
                let trackMotion : CMAttitude = data.attitude
                motionManager.deviceMotionUpdateInterval = 1.0
                DispatchQueue.main.async {
                    pitch = trackMotion.pitch
                    yaw = trackMotion.yaw
                    roll = trackMotion.roll
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
