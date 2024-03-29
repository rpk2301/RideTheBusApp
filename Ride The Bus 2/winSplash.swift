import SwiftUI
import AVFoundation

struct WinSplashView: View {
    @State private var isActive = false
    @State private var size: CGFloat = 0.8
    @State private var opacity = 0.5
    @State private var textOpacity = 0.0
    @State private var imageOpacity = 0.0 // New state for image opacity
    let score: Int
    let audioPlayer: AVAudioPlayer? // Add AVAudioPlayer as a property

    init(score: Int) {
        self.score = score

        // Initialize the audio player with the mp3 file
        if let soundURL = Bundle.main.url(forResource: "BusEnd", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
        } else {
            audioPlayer = nil
        }
    }

    var body: some View {
        if isActive {
            FinishScreen(score: score)
        } else {
            VStack {
                HStack {
                    Image("bus2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 200, maxHeight: 250)
                        .rotationEffect(.degrees(90))
                        .opacity(imageOpacity) // Apply opacity based on state

                    Text("Well Done! You Rode The Bus For \(score) Cards")
                        .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                        .font(.system(size: 30.0))
                        .fontWeight(.medium)
                        .foregroundColor(Color.yellow)
                        .multilineTextAlignment(.center)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50.0, height: 500.0)
                        .opacity(textOpacity)
                        .foregroundColor(.white)
                        .rotationEffect(.degrees(90))
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.2
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.easeIn(duration: 1.0)) {
                            self.textOpacity = 1.0 // gradually increase text opacity
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                        withAnimation(.easeIn(duration: 1.0)) {
                            self.imageOpacity = 1.0 // gradually increase image opacity
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Play the audio when the screen appears
                audioPlayer?.play()

                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    // Stop the audio after a certain duration
                    if let player = audioPlayer, player.isPlaying {
                        player.stop()
                    }

                    // Update the isActive flag to trigger navigation
                    self.isActive = true
                }
            }
        }
    }
}

#if DEBUG
struct WinSplashView_Previews: PreviewProvider {
    static var previews: some View {
        WinSplashView(score: 200)
    }
}
#endif

