import SwiftUI

struct CustomPopup: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            // Background overlay
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.4)
            
            if isShowing {
                // Text displayed horizontally across the screen
                Text("Congratulations, you rode the bus")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(-90))
                    .offset(x: -UIScreen.main.bounds.width / 2 + 80, y: UIScreen.main.bounds.height / 2)
            }
        }
    }
}

struct Testing2: View {
    @State private var isPopupVisible = true

    var body: some View {
        ZStack {
            Image("background-cloth")
            
            // Button to show the popup
            Button(action: {
                self.isPopupVisible.toggle()
            }) {
                Text("Show Popup")
            }
            .padding()
        }
        .overlay(
            CustomPopup(isShowing: $isPopupVisible)
        )
    }
}

#if DEBUG
struct Testing2_Previews: PreviewProvider {
    static var previews: some View {
        Testing2()
    }
}
#endif

