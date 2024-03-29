import SwiftUI

struct FinishScreen: View {
    let score: Int
    @State private var isGlowing = false
    @State private var playerName = ""
    @State private var goGame = false
    @State private var goHome = false
    @State private var goToLeaderboard = false
    @State private var showNameInput = false
    
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
                                showNameInput = true
                            }) {
                                Text("Add To Leaderboard")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 140, height: 100)
                                    .foregroundColor(.white)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.1, green: 0.7, blue: 0.1),
                                                Color(red: 0.7, green: 0.9, blue: 0.7) // Light green
                                                    
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                            }
                            .sheet(isPresented: $showNameInput) {
                                NameInputView(playerName: $playerName, addToLeaderboard: { name in
                                    if !name.isEmpty {
                                        let initialScore = self.score
                                        UserDataFileManager.saveScore(forPlayer: name, score: initialScore)
                                        self.goHome = true
                                    }
                                })
                            }
                            .rotationEffect(.degrees(90))
                            .padding()
                            
                            Button(action: { goGame = true }) {
                                Text("Play Again")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 140, height: 100)
                                    .foregroundColor(.white)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.95, green: 0.85, blue: 0.2),
                                                 Color(red: 0.85, green: 0.65, blue: 0.05)
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                            }
                            .rotationEffect(.degrees(90))
                            .padding()
                            
                            Button(action: { goHome = true }) {
                                Text("Exit")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .bold()
                                    .frame(width: 140, height: 100)
                                    .foregroundColor(.white)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 0.9, green: 0.3, blue: 0.3), // Dark Red
                                                      Color(red: 0.2, green: 0.0, blue: 0.0) // Black // Black
                                            ]),
                                            startPoint: .bottomLeading,
                                            endPoint: .topLeading
                                        )
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                    .shadow(radius: 3)
                                    
                            }
                            .rotationEffect(.degrees(90))
                            .padding()
                            .navigationBarBackButtonHidden()
                        }
                        
                        ZStack {
                          
                            
                            Text("Play Again?")
                                .rotationEffect(.degrees(90))
                                .frame(width: 220.0, height: 400.0)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                .font(.system(size: 30.0))
                                .fontWeight(.medium)
                                .foregroundColor(Color.yellow)
                                .multilineTextAlignment(.center)
                                .scaleEffect(isGlowing ? 1.7 : 1.0)
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                                        self.isGlowing.toggle() 
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


