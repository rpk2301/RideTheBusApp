import SwiftUI

struct HowToPlay: View {
    var body: some View {
        ZStack {
            Image("background-cloth")
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                Text("How to Play")
                    .padding(.top, 70.0)
                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                    .font(.system(size: 60.0))
                    .fontWeight(.medium)
                    .foregroundColor(Color.yellow)
                    .multilineTextAlignment(.center)
                
                ScrollView(.vertical, showsIndicators: false) { // Change to vertical scrollview
                    VStack(spacing: 0) { // Change to VStack
                        
                        
                        SlideView(title: "Ride The Bus Is Played With Five Cards Laid Horizonatlly", description: "The Highlighted Card Is The Posistion You Are Currently In", imageName: "board")
                            .frame(width: UIScreen.main.bounds.width, height: 500
                        )
                        SlideView(title: "Ride The Bus!", description: "Correctly Guess Factors About The Next Card In The Deck To Advance Posistions", imageName: "board").frame(width: UIScreen.main.bounds.width, height: 500.0)
                        SlideView(title: "Stacks 1 and 2", description: "On The First Two Stacks, Guess Whether The Next Card Drawn Will Be Higher Or Lower Than The Highlighted Card", imageName: "firstTwo")
                        SlideView(title: "Stacks 3 and 4", description: "On The Final Two Stacks, Guess The Next Cards Color And Suit", imageName: "finalTwo").frame(width: UIScreen.main.bounds.width, height: 500.0)
                        SlideView(title: "Progression", description: "A Correct Guess Will Advance You One Stack, While An Incorrect Guess Will Move You One Stack Back", imageName: "moveUp")
                    }
                    .frame(maxWidth: .infinity) // Adjust frame width
                }
                .padding(.horizontal, 20)
            }
        }
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
        .frame(maxWidth: .infinity) // Adjust frame width
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlay()
    }
}

