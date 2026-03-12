import CoreLocation

protocol LocationServicing {
    func requestCity(completion: @escaping (String) -> Void)
}

final class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    private let manager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    private var completion: ((String) -> Void)?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestCity(completion: @escaping (String) -> Void) {
        
        self.completion = completion
        
        let status = manager.authorizationStatus
        
        switch status {
            
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
            
        case .denied, .restricted:
            completion("Moscow")
            
        @unknown default:
            completion("Moscow")
        }
    }
}

extension LocationManager: LocationServicing {}

extension LocationManager: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        let status = manager.authorizationStatus
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            manager.requestLocation()
        } else if status == .denied {
            completion?("Moscow")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.first else {
            completion?("Moscow")
            return
        }
        
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, error in
            
            guard let self else { return }
            
            if let city = placemarks?.first?.locality {
                completion?(city)
            } else {
                completion?("Moscow")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        completion?("Moscow")
    }
}
