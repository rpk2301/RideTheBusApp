import SwiftUI

struct FinishScreen: View {
    let score: Int
    @State private var isGlowing = false
    @State private var playerName = ""
    @State private var goGame = false
    @State private var goHome = false
    @State private var goToLeaderboard = false // Add state for controlling navigation to leaderboard
    @State private var showNameInput = false // Add state for controlling name input sheet
    
    init(score: Int) {
        self.score = score
    }
    
    var body: some View {
        if goHome {
            ContentView()
        } else if goGame {
            GamePage()
        } else if goToLeaderboard {
            Leaderboard()
        } else {
            NavigationView {
                ZStack {
                    Image("background-cloth")
                    // Background overlay
                    LinearGradient(gradient: Gradient(colors: [Color.green, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .edgesIgnoringSafeArea(.all)
                        .opacity(0.4)
                    
                    HStack {
                        VStack(spacing: 120) {
                            Button(action: {
                                showNameInput = true // Show name input sheet when button is tapped
                            }) {
                                Text("Add To Leaderboard")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.green)
                                    .cornerRadius(10)
                            }
                            .sheet(isPresented: $showNameInput) {
                                NameInputView(playerName: $playerName, addToLeaderboard: { name in
                                    if !name.isEmpty {
                                        let initialScore = self.score
                                        UserDataFileManager.saveScore(forPlayer: name, score: initialScore)
                                        self.goHome = true // Navigate to leaderboard
                                    }
                                })
                            }
                            .rotationEffect(.degrees(90))
                            .padding()
                            
                            Button(action: { goGame = true }) {
                                Text("Play Again")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.blue)
                                    .cornerRadius(10)
                            }
                            .rotationEffect(.degrees(90))
                            .padding()
                            
                            Button(action: { goHome = true }) {
                                Text("Exit")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.red)
                                    .cornerRadius(10)
                            }
                            .rotationEffect(.degrees(90))
                            .padding()
                            .navigationBarBackButtonHidden()
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color(red: 0, green: 0.7, blue: 0, opacity: 0.6), Color(red: 0.8, green: 0.3, blue: 0, opacity: 0.4)]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.yellow.opacity(0.6), lineWidth: 3)
                                        .shadow(color: Color.black.opacity(0.8), radius: 20, x: 0, y: 0) // Add a shadow for the glow effect
                                )
                                .frame(width: 220.0, height: 300.0)
                            
                            Text("Play Again?")
                                .rotationEffect(.degrees(90))
                                .frame(width: 220.0, height: 400.0)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                .font(.system(size: 30.0))
                                .fontWeight(.medium)
                                .foregroundColor(Color.yellow)
                                .multilineTextAlignment(.center)
                                .scaleEffect(isGlowing ? 1.2 : 1.0) // Scale effect based on isGlowing state
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                        self.isGlowing.toggle() // Toggle the state to trigger animation
                                    }
                                }
                        }
                        .padding(.trailing, 30.0)
                    }
                }
            }
            
            .navigationBarBackButtonHidden()
        }
    }
}

struct FinishScreen_Previews: PreviewProvider {
    static var previews: some View {
        FinishScreen(score: 184)
    }
}

struct NameInputView: View {
    @Binding var playerName: String
    var addToLeaderboard: (String) -> Void
    
    var body: some View {
        ZStack {
            Image("background-cloth")
            Text("Add Name To Leaderboard")
                .padding(.bottom, 400.0)
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                .font(.system(size: 30.0))
                .fontWeight(.medium)
                .foregroundColor(Color.yellow)
                .multilineTextAlignment(.center)
            
            VStack {
                TextField("Name", text: $playerName)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    addToLeaderboard(playerName)
                }) {
                    Text("Add")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }
}


