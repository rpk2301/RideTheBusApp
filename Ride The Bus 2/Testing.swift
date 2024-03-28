import SwiftUI

struct CustomPopup: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            // Background overlay
            LinearGradient(gradient: Gradient(colors: [Color.green, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.4) // Adjust opacity as needed
            
            // Popup content
            VStack {
                Text("Congratulations, You Rode The Bus!")
                    .padding()
                    .foregroundColor(.white) // Set text color to white to contrast with the gradient background
                    .background(Color.black.opacity(0.8)) // Add a semi-transparent background for better readability
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    .rotationEffect(.degrees(90))
                
                Button("Close") {
                    self.isShowing = false
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .opacity(isShowing ? 1 : 0)
        .animation(.easeInOut)
    }
}

struct Testing2: View {
    @State private var isPopupVisible = false

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

