import SwiftUI
import AVFoundation
struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @State private var textOpacity = 0.0

    var body: some View {
        if isActive {
            Testing2()
        } else {
            VStack {
                VStack {
                    Image("rtb")
                        
                    Text("Kyte Studios")
                        .font(.body)
                        .fontWeight(.heavy)
                        .multilineTextAlignment(.center)
                      
                        .font(Font.custom("Baskerville-Bold", size: 20))
                        .foregroundColor(.white.opacity(0.80))
                       
                        .opacity(textOpacity)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 1.2
                        self.opacity = 1.0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                        withAnimation(.easeIn(duration: 0.5)) {
                            self.textOpacity = 0.0
                        }
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
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

