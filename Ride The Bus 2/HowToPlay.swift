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
                    .padding(.top, 100.0)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    .font(.system(size: 60.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.yellow)
                    .multilineTextAlignment(.center)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        SlideView(title: "Ride The Bus Is Played With Five Cards Laid Horizonatlly", description: "The Highlighted Card Is The Posistion You Are Currently In", imageName: "board")
                            .frame(width: UIScreen.main.bounds.width, height: 500)
                        SlideView(title: "Ride The Bus!", description: "Correctly Guess Factors About The Next Card In The Deck To Advance Posistions", imageName: "board").frame(width: UIScreen.main.bounds.width, height: 500.0)
                        SlideView(title: "Stacks 1 and 2", description: "On The First Two Stacks, Guess Whether The Next Card Drawn Will Be Higher Or Lower Than The Highlighted Card", imageName: "firstTwo")
                        SlideView(title: "Stacks 3 and 4", description: "On The Final Two Stacks, Guess The Next Cards Color And Suit", imageName: "finalTwo").frame(width: UIScreen.main.bounds.width, height: 500.0)
                        SlideView(title: "Progression", description: "A Correct Guess Will Advance You One Stack, While An Incorrect Guess Will Move You One Stack Back", imageName: "moveUp")
                        SlideView(title: "View A Stack", description: "Select A Stack To View Its Contents - This Can Help You Make A Guess On Later Stacks In The Bus", imageName: "Select1")
                        SlideView(title: "Win!", description: "Progressing Through The Entire Bus Will Take You To The Win Screen - Congratulations, You Just Rode The Bus!", imageName: "Win1")
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 20)
            }
        }
        .navigationBarTitle("", displayMode: .inline) // Hide navigation bar title
        .navigationBarHidden(false) // Show navigation bar
        .navigationBarBackButtonHidden(true) // Hide default back button
        .navigationBarItems(leading:
            Button(action: {
            presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "arrow.left") // Custom back button image
                    .foregroundColor(.yellow)
                    .padding()
            }
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

