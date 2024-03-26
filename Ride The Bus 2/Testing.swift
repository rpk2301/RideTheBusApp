import SwiftUI

struct Testing: View {
    @State private var isGlowing = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Image("background-cloth")
                
                VStack{
                    Image("3_of_hearts")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.8) // Adjust size as needed
                        .frame(width: 310.0, height: 450.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.yellow, lineWidth: 10)
                                .blur(radius: 5)
                                .opacity(self.isGlowing ? 1.0 : 0.0) // Toggle visibility
                        )
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                self.isGlowing = true // Start the animation
                            }
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#if DEBUG
struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
#endif

