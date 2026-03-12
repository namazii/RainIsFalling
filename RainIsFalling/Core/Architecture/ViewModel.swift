import Foundation

@MainActor
protocol ViewModel: AnyObject, ObservableObject {}

@MainActor
protocol ViewModelIntent: ViewModel {
    associatedtype ViewState
    associatedtype Intent
    
    var state: ViewState { get }
    func send(_ intent: Intent)
}
