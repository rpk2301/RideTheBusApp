import SwiftUI
import WebKit

struct ContentView: View {
    
    @State private var GoToGame = false
    @State private var goToLeaderboard = false
    
    var body: some View {
        if(GoToGame == true){
            GamePage()
            }
        else if(goToLeaderboard==true){
            Leaderboard()
        }
        else{
            
            NavigationView{
                ZStack{
                    Image("background-cloth")
                        .ignoresSafeArea(.all)
                    
                    VStack{
                        Spacer()
                        
                        VStack{
                            Text("Ride The Bus")
                                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                .font(.system(size: 60.0))
                                .fontWeight(.medium)
                                .foregroundColor(Color.yellow)
                                .multilineTextAlignment(.center)
                                .padding(.top, UIScreen.main.bounds.height < 737 ? 00.0 : 50.0)
                            
                                .padding(.top, UIScreen.main.bounds.height < 737 ? 00.0 : 50.0)
                            
                            Image("bus2")
                                .resizable() 
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: UIScreen.main.bounds.height < 737 ? 300 : 400, maxHeight: UIScreen.main.bounds.height < 737 ? 155 : 250)
                        }
                        if UIScreen.main.bounds.height > 737 {
                               Spacer()
                           }
                        Button(action:{GoToGame = true
                        }, label: {
                            
                            Text("Play")
                                .font(.title2)
                                .fontWeight(.bold)
                                .bold()
                                .frame(width: 200, height: 50)
                                .foregroundColor(.yellow)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.8, green: 0.6, blue: 0.2),
                                            Color(red: 0.1, green: 0.4, blue: 0.2)
                                        ]),
                                        startPoint: .bottomLeading,
                                        endPoint: .topLeading
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                .shadow(radius: 3)
                            
                            
                            
                        })
                        NavigationLink(destination: HowToPlay()) {
                            Text("How to Play")
                                .font(.title2)
                                .fontWeight(.bold)
                                .bold()
                                .frame(width: 200, height: 50)
                                .foregroundColor(.yellow)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.8, green: 0.6, blue: 0.2),
                                            Color(red: 0.1, green: 0.4, blue: 0.2)
                                        ]),
                                        startPoint: .bottomLeading,
                                        endPoint: .topLeading
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                .shadow(radius: 3)
                        }
                        .padding(.vertical)
                        
                        
                        
                        NavigationLink(destination: Leaderboard()){
                            Text("Leaderboard")
                                .font(.title2)
                                .fontWeight(.bold)
                                .bold()
                                .frame(width: 200, height: 50)
                                .foregroundColor(.yellow)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [
                                            Color(red: 0.8, green: 0.6, blue: 0.2),
                                            Color(red: 0.1, green: 0.4, blue: 0.2)
                                        ]),
                                        startPoint: .bottomLeading,
                                        endPoint: .topLeading
                                    )
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                                .shadow(radius: 3)
                        }
                        
                        
                        if UIScreen.main.bounds.height > 667 {
                               Spacer()
                           }
                       
                        HStack{
                            Spacer()
                            VStack{
                                Text("\(UserDataFileManager.displayTotalScore())")
                                    .padding(0.0)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2) // Example shadow
                                    .font(.system(size: 40.0))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.yellow)
                                
                                Text("Cards Ridden")
                                    .padding(.bottom, 15.0)
                                    .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 2)
                                    .font(.system(size: 25.0))
                                    .fontWeight(.medium)
                                    .foregroundColor(Color.yellow)
                            }
                            Spacer()
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                }
            }
        }
        
    }
    
}
#Preview {
    ContentView()
}
