import SwiftUI

class ParticlesProps: ObservableObject {
    // @Published var props: NSMutableDictionary = [:]
    @Published var mode = ""
}

struct ParticlesView: View {
    @ObservedObject var props = ParticlesProps()
    @State private var particleSystem = ParticleSystem()
    @State private var motionHandler = MotionManager()
    let options: [(flipX: Bool, flipY: Bool)] = [
        (false, false),
        (true, false),
        (false, true),
        (true, true),
    ]

    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size in
                let timelineDate = timeline.date.timeIntervalSinceReferenceDate
                particleSystem.update(date: timelineDate)
                context.blendMode = .plusLighter

                particleSystem.center = UnitPoint(x: 0.5 + motionHandler.roll, y: 0.5 + motionHandler.pitch)

                for particle in particleSystem.particles {
                    var contextCopy = context
                    contextCopy.addFilter(.colorMultiply(Color(hue: particle.hue, saturation: 1, brightness: 1)))
                    contextCopy.opacity = 1 - (timelineDate - particle.creationDate)

                    if props.mode == "simple" {
                        let xPos = particle.x * size.width
                        let yPos = particle.y * size.height
                        contextCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                    } else {
                        for option in options {
                            var xPos = particle.x * size.width
                            var yPos = particle.y * size.height

                            if option.flipX {
                                xPos = size.width - xPos
                            }

                            if option.flipY {
                                yPos = size.height - yPos
                            }
                            contextCopy.draw(particleSystem.image, at: CGPoint(x: xPos, y: yPos))
                        }
                    }
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { drag in
                    particleSystem.center.x = drag.location.x  / UIScreen.main.bounds.width
                    particleSystem.center.y = drag.location.y  / UIScreen.main.bounds.height
                }
        )
        .edgesIgnoringSafeArea(.all)
        .background(Color.black)
    }
}

struct ParticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ParticlesView()
    }
}