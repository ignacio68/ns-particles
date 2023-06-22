import SwiftUI

struct Particle: Hashable {
  let x: Double
  let y: Double
  let creationDate = Date.now.timeIntervalSinceReferenceDate
  let hue: Double
}