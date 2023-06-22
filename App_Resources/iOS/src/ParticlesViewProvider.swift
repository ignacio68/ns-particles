import SwiftUI

@objc
class ParticlesViewProvider: UIViewController, SwiftUIProvider {

  // MARK: INIT
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  required public init() {
    super.init(nibName: nil, bundle: nil)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupSwiftUIView(content: swiftUIView)
  }

  // MARK: PRIVATE
  private var swiftUIView = ParticlesView()

  // Receive data from NativeScript
  // func updateData(data: NSDictionary) {
  //   data.forEach { (k,v) in swiftUIView.data.props[k] = v }
  // }
  func updateData(data: NSDictionary) {
    if let mode = data.value(forKey: "mode") as? String {
      // update swiftUI view
      swiftUIView.props.mode = mode
      // notify nativescript
      self.onEvent?(["mode": mode])
    }
  }

  /// Allow sending of data to NativeScript
  var onEvent: ((NSDictionary) -> ())?
}