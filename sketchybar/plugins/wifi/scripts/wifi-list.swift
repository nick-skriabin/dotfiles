import Foundation
import CoreWLAN

class NetworkScanner {
    var currentInterface: CWInterface
    
    init?() {
        self.currentInterface = CWInterface()
        self.scanForNetworks()
    }
    func currentSSID() {
        print("current ssid: \(currentInterface.ssid() ?? "Unknown")")
    }
    
    func scanForNetworks() {
        do {
            let networks = try currentInterface.scanForNetworks(withName: nil)
            for network in networks {
                print("\(network.ssid ?? "Unknown")")
            }
        } catch let error as NSError {
            print("Error: \(error.localizedDescription)")
        }
    }
}

var wlan = NetworkScanner()

wlan?.scanForNetworks()
wlan?.currentSSID()
