import SwiftUI
import AWSDynamoDB

struct Leaderboard: View {
    @Environment(\.presentationMode) var presentationMode
   
    @State private var players: [(String, Int)] = []
    
    var body: some View {
        ZStack{
            Image("background-cloth")
                .ignoresSafeArea(.all)
            
            VStack {
                Text("Leaderboard")
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    .font(.system(size: 40.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.yellow)
                    .multilineTextAlignment(.center)
                    .padding(.top, UIScreen.main.bounds.height < 737 ? 200.0 : 100.0)
                
                if players.isEmpty {
                    Text("No Scores Saved")
                        .font(.system(size: 25.0))
                        .fontWeight(.medium)
                        .foregroundColor(Color.yellow)
                        .padding(.bottom, 650.0)
                        .padding(.top, 50.0)
                }
                else{
                    // Leaderboard view
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(players.indices, id: \.self) { index in
                                let player = players[index]
                                HStack {
                                    Text(player.0)
                                    Spacer()
                                    Text("\(player.1)")
                                    Button(action: {
                                        deletePlayer(at: index)
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                                .background(Color.secondary.opacity(0.1))
                                .cornerRadius(8)
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                .font(.system(size: 25.0))
                                .fontWeight(.medium)
                                .foregroundColor(Color.yellow)
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .onAppear {
            loadPlayerData()
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left")
                    .foregroundColor(.yellow)
                    .padding()
            }
        )
    }
    
    private func loadPlayerData() {
        if let textFiles = UserDataFileManager.listTextFiles() {
            var playerScores: [(String, Int)] = []
            for fileName in textFiles {
                if let playerId = fileName.split(separator: ".").first {
                    let playerName = String(playerId)
                    if playerName != "TotalScore" {
                        if let score = UserDataFileManager.loadScore(forPlayer: playerName) {
                            playerScores.append((playerName, score))
                        }
                    }
                }
            }
            players = playerScores.sorted(by: { $0.1 > $1.1 })
        }
    }
    
    private func deletePlayer(at index: Int) {
        let player = players.remove(at: index)
        UserDataFileManager.deletePlayer(player.0)
    }
}

struct Leaderboard_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            Leaderboard()
        }
    }
}
