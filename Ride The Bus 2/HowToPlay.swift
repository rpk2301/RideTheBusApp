import SwiftUI

struct HowToPlay: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image("background-cloth")
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                Text("How to Play")
                    .padding(.top, UIScreen.main.bounds.width < 385 ? 150 : 100.0)
                       .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                       .font(.system(size: UIScreen.main.bounds.width < 375 ? 40.0 : 60.0))
                       .fontWeight(.medium)
                       .foregroundColor(Color.yellow)
                       .multilineTextAlignment(.center)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        SlideView(title: "Ride The Bus Is Played With Five Cards Laid Horizonatlly", description: "The Highlighted Card Is The Posistion You Are Currently In", imageName: "board")
                            .frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "Ride The Bus!", description: "Correctly Guess Factors About The Next Card In The Deck To Advance Posistions", imageName: "board").frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "Stacks 1 and 2", description: "On The First Two Stacks, Guess Whether The Next Card Drawn Will Be Higher Or Lower Than The Highlighted Card", imageName: "firstTwo")
                        SlideView(title: "Stacks 3 and 4", description: "On The Final Two Stacks, Guess The Next Cards Color And Suit", imageName: "finalTwo").frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "Progression", description: "A Correct Guess Will Advance You One Stack, While An Incorrect Guess Will Move You Back", imageName: "moveUp").frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "View A Stack", description: "Select A Stack To View Its Contents - This Can Help You Make A Guess On Later Stacks In The Bus", imageName: "Select1").frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "Win!", description: "Progressing Through The Entire Bus Will Take You To The Win Screen - Congratulations, You Just Rode The Bus!", imageName: "Win1").frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "Total Miles", description: "On Your Homescreen, You Can See The Total Cards Rode On Your Device", imageName: "ridden")
                        SlideView(title: "Leaderboard", description: "Visit The Leaderboard To See Your Best And Worse Rides - Add A Score From The Win Screen", imageName: "leader").frame(height: UIScreen.main.bounds.height * 0.6)

                        SlideView(title: "Thank You", description: "Thanks For Reading, And Enjoy Your Ride!", imageName: "rtb").frame(height: UIScreen.main.bounds.height * 0.6)
                        SlideView(title: "", description: "", imageName: "")
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
            }
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
                    .padding(EdgeInsets(top: 0, leading: UIScreen.main.bounds.width < 375 ? 10 : 20, bottom: 0, trailing: 0))
            }
            .zIndex(1) // Ensure the button appears on top
        )
    }
}

struct SlideView: View {
    let title: String
    let description: String
    let imageName: String
    
    var body: some View {
        VStack {
            Text(title)
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                .font(.title)
                .fontWeight(.medium)
                .foregroundColor(Color.yellow)
                .multilineTextAlignment(.center)
                .padding()
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(description)
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                .font(.system(size: 22))
                .fontWeight(.medium)
                .foregroundColor(Color.yellow)
                .multilineTextAlignment(.center)
                .padding()
        }
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HowToPlay()
        }
    }
}

