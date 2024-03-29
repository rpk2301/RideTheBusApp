import SwiftUI
import AVFoundation

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var textOpacity = 0.0 
   
    
   
    let audioPlayer: AVAudioPlayer?
    
    init() {
        if let soundURL = Bundle.main.url(forResource: "BusIntro2", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: soundURL)
        } else {
            audioPlayer = nil
        }
    }
    
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image("rtb")
                        
                        .onAppear {
                            withAnimation(.easeIn(duration: 1.2)) {
                                self.size = 1.5
                                self.opacity = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    self.textOpacity = 1.0 // Fade in the text
                                }
                            }
                        }
                    
                  
                }
                .scaleEffect(size)
                .opacity(opacity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                audioPlayer?.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                    if let player = audioPlayer, player.isPlaying {
                        player.stop()
                    }
                    self.isActive = true
                }
            }
        }
    }
}

#if DEBUG
struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
#endif

