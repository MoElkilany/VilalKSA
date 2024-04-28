//
//  NetworkMonitor.swift
//  VilalKSA
//
//  Created by Elkilany on 20/01/2024.
//

import Network
import Combine

class NetworkReachabilityManager: ObservableObject {
    
    let monitor: NWPathMonitor
    let queue = DispatchQueue(label: "NetworkMonitor")

    @Published var isConnected: Bool = true

    init() {
        monitor = NWPathMonitor()
       
        monitor.pathUpdateHandler = { [weak self] path in
            DispatchQueue.main.async {
                self?.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
    
}
