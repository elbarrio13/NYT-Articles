//
//  NetworkMonitor.swift
//  NYT-Articles
//
//  Created by Xavier on 3/31/25.
//

import Combine
import Network

class NetworkMonitor: ObservableObject {
    @Published private(set) var isConnected = true

    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()

    init() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.isConnected = true
            } else {
                self.isConnected = false
            }
        }

        let queue = DispatchQueue(label: Constants.Content.MONITOR)
        monitor.start(queue: queue)
    }

    /**
     Call this function to monitoring and get the network state changes

     - Returns: A bool indicating if the network is coonected or disconnected.
     */
    func getNetworkState() -> Bool {
        return isConnected
    }
}
