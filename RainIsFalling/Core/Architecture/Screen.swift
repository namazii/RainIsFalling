import SwiftUI

protocol Screen: UIViewController  {
    associatedtype ViewModelType: ViewModel
    var viewModel: ViewModelType { get }
}
