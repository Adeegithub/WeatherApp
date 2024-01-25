//
//  NetworkMonitor.swift
//  WeatherAppCW
//
//  Created by Adeesha Arunoda Gunawardana on 5/1/2024.
//

import Foundation
import Network

class InternetStatusListener: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @Published var isActive = false
    @Published var connectionType = NWInterface.InterfaceType.other
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            }
        }
        monitor.start(queue: queue)
        print(self.isActive)
    }
}
